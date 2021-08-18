import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shopin/components/constant/constant.dart';
import 'package:shopin/components/constant/end_point.dart';
import 'package:shopin/models/user_model/user_model.dart';
import 'package:shopin/shared/bloc/user_bloc/user_states.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopin/shared/network/local/cache_helper.dart';
import 'package:shopin/shared/network/remote/dio_helper.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitialState());

  static UserCubit get(context) => BlocProvider.of(context);

  bool password = false;

  ///Password state
  void passwordState() {
    password = !password;
    emit(UserPasswordState());
  }

  ///LOGIN BY GMAIL
  void gmailAuthentication() async {
    emit(UserDataLoadingState());
    await Authentication.googleAuthentication(endPoint: LOGIN)
        .then((value) async {
      if (!value!.data['status']) {
        await Authentication.googleAuthentication(endPoint: REGISTER)
            .then((value) async {
          userModel = UserModel.fromJson(value!.data);
          if (userModel!.status) {
            token = userModel!.data!.token;
            await CacheHelper.setData(
                key: 'token', value: userModel!.data!.token);
            emit(UserDataSuccessState());
          } else {
            emit(UserDataErrorState(onError.toString()));
          }
        });
      } else {
        userModel = UserModel.fromJson(value.data);
        token = userModel!.data!.token;
        await CacheHelper.setData(key: tokenKey, value: userModel!.data!.token);

        emit(UserDataSuccessState());
      }
    });
  }

  ///LOGIN BY Facebook
  void fBookAuthentication() async {
    emit(UserDataLoadingState());
    await Authentication.facebookAuthentication(endPoint: LOGIN)
        .then((value) async {
      if (!value!.data['status']) {
        await Authentication.facebookAuthentication(endPoint: REGISTER)
            .then((value) async {
          userModel = UserModel.fromJson(value!.data);
          if (userModel!.status) {
            token = userModel!.data!.token;
            await CacheHelper.setData(
                key: 'token', value: userModel!.data!.token);
            emit(UserDataSuccessState());
          } else {
            emit(UserDataErrorState(onError.toString()));
          }
        });
      } else {
        userModel = UserModel.fromJson(value.data);
        token = userModel!.data!.token;
        await CacheHelper.setData(key: tokenKey, value: userModel!.data!.token);

        emit(UserDataSuccessState());
      }
    });
  }

  void apiAuthentication({
    required String endPoint,
    required String email,
    required String password,
    String name = '',
    String phoneNumber = '',
  }) async {
    emit(UserDataLoadingState());
    await Authentication.apiAuthentication(
      endPoint: endPoint,
      email: email,
      password: password,
      name: name,
      phoneNumber: phoneNumber,
    ).then((value) async {
      if (!value.data['status']) {
        userModel = UserModel.fromJson(value.data);

        emit(UserDataErrorState(onError.toString()));
      } else {
        userModel = UserModel.fromJson(value.data);
        token = userModel!.data!.token;
        await CacheHelper.setData(key: 'token', value: userModel!.data!.token);
        emit(UserDataSuccessState());
      }
    });
  }
}

///Authentication Class
class Authentication {
  static User? _user;
  static Response<dynamic>? userData;

  ///Sign by gmail *FireBase*
  static Future<Response<dynamic>?> googleAuthentication({
    required String endPoint,
  }) async {
    await GoogleSignIn().signIn().then((value) async {
      await value!.authentication.then((authentication) async {
        ///credential
        final AuthCredential credential = _googleCredential(
            accessToken: authentication.accessToken,
            idToken: authentication.idToken);

        ///signIn
        await _singInWithCredential(credential).then((value) async {
          _user = value!;

          ///Api
          await apiAuthentication(
            endPoint: endPoint,
            name: _user!.displayName!,
            password: _user!.uid,
            phoneNumber: _user!.phoneNumber ?? _user!.providerData.first.uid!,
            image: _user!.photoURL!,
            email: _user!.email!,
          ).then((value) {
            userData = value;
          });
        });
      });
    });

    return userData;
  }

  ///googleCredential
  static OAuthCredential _googleCredential({
    required accessToken,
    required idToken,
  }) {
    return GoogleAuthProvider.credential(
        accessToken: accessToken, idToken: idToken);
  }

  ///singInWithCredential
  static Future<User?> _singInWithCredential(credential) async {
    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) {
      return value.user;
    });
  }

  static Future<Response<dynamic>> apiAuthentication({
    required String endPoint,
    String? name,
    String? phoneNumber,
    required String email,
    required String password,
    String? image,
  }) async {
    return await DioHelper.setData(
      endPoint: endPoint,
      query: {
        'name': name,
        'phone': phoneNumber,
        'email': email,
        'password': password,
        'image': image,
      },
    ).then((value) async {
      userModel = UserModel.fromJson(value.data);
      if (userModel!.status) {
        token = userModel!.data!.token;
        await CacheHelper.setData(key: 'token', value: userModel!.data!.token);
      }
      return value;
    });
  }

  ///Facebook
  static Future<Response<dynamic>?> facebookAuthentication({
    required String endPoint,
  }) async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential)
        .then((value) async {
      _user = value.user;

      ///Api
      await apiAuthentication(
        endPoint: endPoint,
        name: _user!.displayName,
        password: _user!.uid,
        phoneNumber: _user!.phoneNumber ?? _user!.providerData.first.uid!,
        image: _user!.photoURL!,
        email: _user!.email!,
      ).then((value) {
        userData = value;
      });
      return value;
    });
    return userData;
  }
}

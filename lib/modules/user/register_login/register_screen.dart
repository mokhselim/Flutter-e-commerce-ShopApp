import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shopin/components/components/components.dart';
import 'package:shopin/components/constant/constant.dart';
import 'package:shopin/components/constant/end_point.dart';
import 'package:shopin/layout/layout_screen.dart';
import 'package:shopin/modules/user/register_login/user_widgets.dart';
import 'package:shopin/shared/bloc/user_bloc/user_bloc.dart';
import 'package:shopin/shared/bloc/user_bloc/user_states.dart';
import 'package:shopin/style/colors.dart';

class RegisterScreen extends StatelessWidget {
  final bool login;

  RegisterScreen({required this.login});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final String userState = login ? 'Login' : 'Register';

    return BlocProvider(
      create: (BuildContext context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (BuildContext context, state) {
          if (state is UserDataErrorState) {
            Fluttertoast.showToast(
                    gravity: ToastGravity.CENTER,
                    msg: userModel!.message,
                    backgroundColor: Colors.red,
                    toastLength: Toast.LENGTH_LONG)
                .then((value) {
              Navigator.pop(context);
            });
          }
          if (state is UserDataSuccessState) {
            navigateToAndRemove(context, LayoutScreen());
          }
          if (state is UserDataLoadingState) {
            showCupertinoModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return Center(
                    child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: CircularProgressIndicator()),
                  );
                });
          }
        },
        builder: (BuildContext context, Object? state) {
          var cubit = UserCubit.get(context);
          return Scaffold(
            body: Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    mainColor,
                    Colors.white,
                    Colors.white,
                  ], begin: Alignment.topCenter, end: Alignment.center),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/login.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (!login)
                                defaultTextFormField(
                                  prefixIcon: Icon(
                                    CupertinoIcons.profile_circled,
                                    color: mainColor,
                                  ),
                                  hint: 'name',
                                  inputType: TextInputType.name,
                                  textEditingController: nameController,
                                ),
                              SizedBox(
                                height: 15,
                              ), if (!login)
                                defaultTextFormField(
                                  prefixIcon: Icon(
                                    CupertinoIcons.phone,
                                    color: mainColor,
                                  ),
                                  hint: 'phone',
                                  inputType: TextInputType.phone,
                                  textEditingController: phoneController,
                                ),
                              SizedBox(
                                height: 15,
                              ),
                              defaultTextFormField(
                                prefixIcon: Icon(
                                  CupertinoIcons.mail,
                                  color: mainColor,
                                ),
                                hint: 'MAIL',
                                inputType: TextInputType.emailAddress,
                                textEditingController: emailController,
                              ),
                              SizedBox(height: 15),
                              defaultTextFormField(
                                prefixIcon: Icon(
                                  CupertinoIcons.lock,
                                  color: mainColor,
                                ),
                                hint: 'PASSWORD',
                                inputType: TextInputType.visiblePassword,
                                textEditingController: passwordController,
                                isPassword: !cubit.password,
                                suffixIcon: IconButton(
                                  icon: cubit.password
                                      ? Icon(
                                          CupertinoIcons.eye,
                                          color: mainColor,
                                        )
                                      : Icon(
                                          CupertinoIcons.eye_slash,
                                          color: Colors.grey,
                                        ),
                                  onPressed: () {
                                    cubit.passwordState();
                                  },
                                ),
                              ),
                              SizedBox(height: 20),
                              defaultButton(
                                () {
                                  if (formKey.currentState!.validate()) {
                                    if (login) {
                                      cubit.apiAuthentication(
                                          password: passwordController.text,
                                          email: emailController.text,
                                          endPoint: LOGIN);
                                    } else {
                                      cubit.apiAuthentication(
                                        phoneNumber: phoneController.text,
                                          password: passwordController.text,
                                          email: emailController.text,
                                          name: nameController.text,
                                          endPoint: REGISTER);
                                    }
                                  }
                                },
                                userState,
                              ),
                              Divider(
                                height: 30,
                                color: Colors.grey.shade300,
                                thickness: 1.2,
                              ),
                              facebookButton(() {
                                cubit.fBookAuthentication();
                              }, '$userState with Facebook',
                                  'assets/facebook.svg'),
                              SizedBox(height: 10),
                              gmailButton(() {
                                cubit.gmailAuthentication();
                              }, '$userState with Google', 'assets/google.svg'),
                              SizedBox(
                                height: 30,
                              ),
                              login
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Don't have an account? "),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 12),
                                            child: Text(
                                              'Register',
                                              style: TextStyle(
                                                  color: mainColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Already have an account? '),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 12),
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                  color: mainColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

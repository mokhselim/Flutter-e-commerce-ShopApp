import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopin/components/constant/constant.dart';
import 'package:shopin/layout/layout_screen.dart';
import 'package:shopin/shared/bloc/bloc_observer.dart';
import 'package:shopin/shared/network/local/cache_helper.dart';
import 'package:shopin/shared/network/remote/dio_helper.dart';
import 'package:shopin/style/colors.dart';

import 'modules/user/register_login/user_navigator.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  DioHelper.init();
  await CacheHelper.init();
  token = await CacheHelper.getData(key: tokenKey);


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
          ),
          color: mainColor,
        ),
      ),
      home: token == null ?UserNavigate(): LayoutScreen(),
    );
  }
}

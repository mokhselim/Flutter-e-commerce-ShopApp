import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopin/components/components/components.dart';
import 'package:shopin/layout/layout_screen.dart';
import 'package:shopin/modules/user/register_login/register_screen.dart';
import 'package:shopin/modules/user/register_login/user_widgets.dart';
import 'package:shopin/style/colors.dart';
import 'package:shopin/style/fonts.dart';

class UserNavigate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [mainColor ,mainColor ,Colors.grey, Colors.white,],begin: Alignment.topCenter,end: Alignment.bottomCenter
                ),
              ),
              alignment: Alignment.topCenter,
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 60, right: 20, left: 20),
              child: Image.asset(
                'assets/shopping-from-phone.png',
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                defaultButton(() {
                  navigateTo(
                      context,
                      RegisterScreen(
                        login: false,
                      ));
                }, 'register'),
                SizedBox(
                  height: 30,
                ),
                defaultButton(() {
                  navigateTo(
                      context,
                      RegisterScreen(
                        login: true,
                      ));
                }, 'login'),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    navigateToAndRemove(context, LayoutScreen());
                  },
                  child: Text(
                    'Skip For Now',
                    style: roboto.copyWith(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopin/components/components/components.dart';
import 'package:shopin/modules/cart/cart_screen.dart';
import 'package:shopin/shared/bloc/app_bloc/app_bloc.dart';
import 'package:shopin/style/colors.dart';
import 'package:shopin/style/fonts.dart';

AppBar myAppBar(context, AppCubit cubit) {
  return AppBar(
    centerTitle: true,
    toolbarHeight: 40,
    elevation: 0,
    title: Text(
      appBarTitle[cubit.navBar],
      style: tajawalNormal,
    ),
    actions: [
      IconButton(
        onPressed: () {
          navigateTo(context, CartScreen());
        },
        icon: Icon(
          Icons.shopping_cart,
          size: 20,
        ),
      )
    ],
  );
}

List<String> appBarTitle = [
  'Home',
  'Store',
  'Search',
  'My WishList',
  'Profile',
];

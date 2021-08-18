import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopin/shared/bloc/app_bloc/app_bloc.dart';


BottomNavyBar defaultNavBar(AppCubit cubit) {
  return BottomNavyBar(
    iconSize: 22,
    showElevation: false,
    curve: Curves.fastOutSlowIn,
    animationDuration: Duration(milliseconds: 700),
    itemCornerRadius: 15,
    selectedIndex: cubit.navBar,
    backgroundColor: Colors.white,
    items: [
      BottomNavyBarItem(
          icon: Icon(
            CupertinoIcons.home,
          ),
          title: Text('Home')),
      BottomNavyBarItem(
        icon: Icon(CupertinoIcons.bag),
        title: Text('Store'),
      ),
      BottomNavyBarItem(
        icon: Icon(CupertinoIcons.search),
        title: Text('Search'),
      ),
      BottomNavyBarItem(
        icon: Icon(CupertinoIcons.suit_heart),
        title: Text('WishList'),
      ),
      BottomNavyBarItem(
        icon: Icon(CupertinoIcons.profile_circled),
        title: Text('Profile'),
      ),
    ],
    onItemSelected: (int index) {
      cubit.navBarIndex(index);
    },
  );
}

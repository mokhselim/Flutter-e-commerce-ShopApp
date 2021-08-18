import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopin/components/constant/constant.dart';
import 'package:shopin/style/colors.dart';
import 'package:shopin/style/fonts.dart';

Widget modalBottomSheet(size){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        alignment: Alignment.center,
        height: size.width / 5,
        margin:
        EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        child: Text(
          'Value-Added Tax',
          style: tajawalNormal.copyWith(
              decoration: TextDecoration.none,
              fontSize: size.width / 24,
              wordSpacing: 1.2,
              letterSpacing: 1,
              color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        margin:
        EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.all(10),
        child: Text(
          vat,
          style: tajawalNormal.copyWith(
              decoration: TextDecoration.none,
              fontSize: size.width / 24,
              wordSpacing: 1.2,
              letterSpacing: 1,
              height: 1.5,
              color: Colors.black),
          textAlign: TextAlign.start,
        ),
      ),
    ],
  );
}
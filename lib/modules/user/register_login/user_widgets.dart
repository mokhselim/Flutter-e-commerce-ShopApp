import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopin/style/colors.dart';
import 'package:shopin/style/fonts.dart';

Widget defaultTextFormField({
  required String hint,
  required TextInputType inputType,
  required TextEditingController textEditingController,
  bool isPassword = false,
  required Icon prefixIcon,
  IconButton? suffixIcon,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.grey.shade200,
    ),
    child: TextFormField(
      validator: (value){
        if(value!.isEmpty)
          return "Can't be empty";
      },
      onFieldSubmitted: (value) {
        textEditingController.text = value;
      },
      controller: textEditingController,
      style: roboto,
      obscureText: isPassword,
      // inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[0-9]'))],
      textInputAction: TextInputAction.next,
      cursorColor: mainColor.withOpacity(0.2),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hint,
        hintStyle: roboto.copyWith(color: Colors.grey),
        isCollapsed: false,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.all(5),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: mainColor,
          ),
        ),
      ),
    ),
  );
}

Widget defaultButton(onPressed, String name) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 30),
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      color: mainColor.withOpacity(0.9),
      gradient: LinearGradient(colors: [
        mainColor,
        mainColor.withOpacity(0.8),
        mainColor.withOpacity(0.7),
      ], begin: Alignment.center, end: Alignment.bottomRight),
      borderRadius: BorderRadius.circular(15),
    ),
    child: TextButton(
      onPressed: () {
        onPressed();
      },
      child: Text(
        name.toUpperCase(),
        style: roboto.copyWith(color: Colors.white),
      ),
    ),
  );
}

Widget facebookButton(onPressed, String name, String svgImage) {
  return InkWell(
    onTap: () {
      onPressed();
    },
    child: Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: facebookColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset(
              svgImage,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 5,
            child: Text(
              '$name',
              style: roboto.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget gmailButton(onPressed, String name, String svgImage) {
  return InkWell(
    onTap: () {
      onPressed();
    },
    child: Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(4),
              color: Colors.grey.shade200,
              child: SvgPicture.asset(
                svgImage,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 5,
            child: Text(
              '$name',
              style: roboto.copyWith(color: facebookColor),
            ),
          ),
        ],
      ),
    ),
  );
}

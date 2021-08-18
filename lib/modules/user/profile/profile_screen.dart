import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopin/components/components/components.dart';
import 'package:shopin/components/constant/constant.dart';
import 'package:shopin/modules/user/profile/user_Row.dart';
import 'package:shopin/modules/user/profile/profile_data.dart';
import 'package:shopin/modules/user/register_login/user_navigator.dart';
import 'package:shopin/modules/user/register_login/user_widgets.dart';
import 'package:shopin/style/colors.dart';
import 'package:shopin/style/fonts.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (userModel == null) {
      return Center(
        child: defaultButton(() {
          navigateTo(context, UserNavigate());
        }, 'Create Account'),
      );
    } else
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      foregroundImage: NetworkImage(
                        userModel!.data!.image,
                      ),
                      radius: size.width / 7,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: mainColor,
                      shape: BoxShape.circle,
                    ),
                    margin: EdgeInsets.only(
                        left: size.width / 3.5, top: size.width / 7),
                    padding: EdgeInsets.all(2),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: size.width / 28,
                      child: InkWell(
                        onTap: () {},
                        child: Icon(
                          CupertinoIcons.camera,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.width / 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          userModel!.data!.name,
                          style: tajawalNormal.copyWith(
                              color: Colors.white,
                              fontSize: size.width / 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          userModel!.data!.email,
                          style: tajawalNormal.copyWith(
                            color: Colors.white60,
                            fontSize: size.width / 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.width / 3.4, left: size.width / 2),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white70,
                        size: size.width / 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return UserRow(
                    name: profileData[index].name,
                    size: size,
                    iconData: profileData[index].iconData,
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.grey,
                    indent: size.width / 8,
                    height: 0,
                  );
                },
                itemCount: profileData.length),
          ],
        ),
      );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopin/components/constant/constant.dart';
import 'package:shopin/shared/bloc/app_bloc/app_bloc.dart';
import 'package:shopin/shared/bloc/app_bloc/app_states.dart';
import 'package:shopin/style/colors.dart';
import 'app_bar.dart';
import 'bottomNavBar.dart';

GlobalKey<FormState> formKey = GlobalKey<FormState>();
var searchController = TextEditingController();

class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: myAppBar(context, cubit),
            bottomNavigationBar: defaultNavBar(cubit),
            body: SafeArea(
              child: Column(
                children: [
                  if (cubit.navBar != 4 && cubit.navBar != 3)
                    Form(
                      key: formKey,
                      child: Container(
                        height: 60,
                        color: mainColor,
                        padding: EdgeInsets.all(10),
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            onFieldSubmitted: (value) {
                              cubit.searchProducts(value);
                            },
                            onChanged: (value) {
                              cubit.searchProducts(value);
                            },
                            onTap: () {
                              cubit.navBarIndex(2);
                              cubit.searchProducts(searchController.text);
                            },
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'What are you looking for?',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: navScreens[cubit.navBar],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

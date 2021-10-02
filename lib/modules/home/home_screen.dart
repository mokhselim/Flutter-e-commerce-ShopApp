import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopin/components/constant/constant.dart';
import 'package:shopin/shared/bloc/app_bloc/app_bloc.dart';
import 'package:shopin/shared/bloc/app_bloc/app_states.dart';
import 'home_comonents.dart';

GlobalKey<FormState> formKey = GlobalKey<FormState>();

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object state) {
        var cubit = AppCubit.get(context);
        if ( homeModel != null ) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                categoriesList(size, categoriesModel!),
                bigBannerList(size, homeModel!),
                saleItemsRow(size, saleProducts!, true, cubit),
                dealsOfTheDay(size, topSaleProducts!, context),
                featureContainer(size),
                saleContainer(),
                dualCamera(size),

              ],
            ),
          );

        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

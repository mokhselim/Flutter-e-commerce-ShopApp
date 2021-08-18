import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopin/components/components/components.dart';
import 'package:shopin/components/constant/constant.dart';
import 'package:shopin/models/shop_model/products_model.dart';
import 'package:shopin/modules/product_screen/product_screen.dart';
import 'package:shopin/shared/bloc/app_bloc/app_bloc.dart';
import 'package:shopin/shared/bloc/app_bloc/app_states.dart';
import 'package:shopin/style/colors.dart';
import 'package:shopin/style/fonts.dart';

Widget bodyWidget(state, AppCubit cubit, size) {
  if (state is AppSearchProductSuccessState &&
      searchProduct!.data.data.isEmpty) {
    return Center(
      child: Text(
        'Item not available',
        style: roboto.copyWith(fontSize: size.width / 20, color: mainColor),
      ),
    );
  } else if (state is AppSearchProductSuccessState) {
    List<ProductData> productData = searchProduct!.data.data;
    return StaggeredGridView.countBuilder(
      physics: BouncingScrollPhysics(),
      crossAxisCount: 4,
      itemCount: productData.length,
      itemBuilder: (BuildContext context, int index) => Stack(
        alignment: Alignment.topRight,
        children: [
          InkWell(
            onTap: () {
              navigateTo(
                context,
                ProductScreen(
                  productData[index],
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: productData[index].image,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        productData[index].name,
                        maxLines: 1,
                        style: tajawal.copyWith(
                            fontSize: size.width / 24,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          productData[index].price.toString(),
                          style: tajawal.copyWith(
                              fontSize: size.width / 28,
                              fontWeight: FontWeight.bold,
                              color: mainColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            splashColor: Colors.transparent,
            onPressed: () {},
            icon: Icon(
              Icons.favorite,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      staggeredTileBuilder: (int index) => StaggeredTile.count(2, 2),
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
    );
  } else if (state is AppSearchProductLoadingState) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Align(
          alignment: Alignment.topCenter,

          child: LinearProgressIndicator(
            backgroundColor: mainColor,
          ),
        ),
      ],
    );
  } else
    return Scaffold();
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopin/components/components/components.dart';
import 'package:shopin/components/constant/constant.dart';
import 'package:shopin/modules/cart/cart_screen.dart';
import 'package:shopin/shared/bloc/app_bloc/app_bloc.dart';
import 'package:shopin/shared/bloc/app_bloc/app_states.dart';
import 'package:shopin/style/fonts.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        if (favoritesProduct == null ||
            favoritesProduct!.data.data.length <= 0) {
          return Center(
            child: Text(
              'No Items',
              style: roboto,
            ),
          );
        } else
          return Container(
            color: Colors.blueGrey[50],
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var product =
                            favoritesProduct!.data.data[index].product;
                        return Dismissible(
                          onDismissed: (direction) {
                            AppCubit.get(context)
                                .setFavorites(product: product.id);
                          },
                          key: UniqueKey(),
                          child: Card(
                            elevation: 0.7,
                            margin: const EdgeInsets.only(
                                bottom: 10, right: 10, left: 10),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        CachedNetworkImage(
                                          height: size.width / 7,
                                          fit: BoxFit.cover,
                                          imageUrl: product.image,
                                        ),
                                        if (product.price < product.oldPrice)
                                          DiscountContainer(
                                              size, product.discount, true),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: tajawal.copyWith(
                                              fontSize: size.width / 28),
                                        ),
                                        if (product.price != product.oldPrice)
                                          Text(
                                            product.oldPrice.toString(),
                                            style: TextStyle(
                                                fontSize: size.width / 30,
                                                color: Colors.grey[700],
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                decorationColor:
                                                    Colors.redAccent,
                                                decorationThickness: 2),
                                          ),
                                        Text(
                                          '${product.price.toString()} EGP',
                                          style: tajawal.copyWith(
                                              fontSize: size.width / 24,
                                              letterSpacing: 1.5),
                                        ),
                                        Text(
                                          'FREE Shipping',
                                          style: tajawal.copyWith(
                                            fontSize: size.width / 34,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: favoritesProduct!.data.data.length),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: Colors.grey[100],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.report,
                            color: Colors.grey,
                          ),
                          Text(
                            'Your Order qualifies for FREE Shipping!',
                            style: tajawal.copyWith(fontSize: size.width / 32),
                          ),
                        ],
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      CupertinoButton(
                          color: Colors.green[400],
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.cart_badge_plus,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'add to cart'.toUpperCase(),
                                  style: TextStyle(fontSize: size.width / 26),
                                ),
                              ],
                            ),
                          ),
                          onPressed: () async {
                           cubit.setUserCart(favoritesProduct);

                          }),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Apply coupon next step',
                        style:
                            tajawalNormal.copyWith(fontSize: size.width / 32),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
      },
    );
  }
}

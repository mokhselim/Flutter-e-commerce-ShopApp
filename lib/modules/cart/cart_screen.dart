import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopin/components/components/components.dart';
import 'package:shopin/components/constant/constant.dart';
import 'package:shopin/shared/bloc/app_bloc/app_bloc.dart';
import 'package:shopin/shared/bloc/app_bloc/app_states.dart';
import 'package:shopin/style/colors.dart';
import 'package:shopin/style/fonts.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getUserCart(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(),
            body: Container(
              color: Colors.blueGrey[50],
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var product = cartModel!.data.cartItems[index];
                          return Dismissible(
                            onDismissed: (direction) {
                              AppCubit.get(context)
                                  .setUserCart(product.product.id);
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
                                            imageUrl: product.product.image,
                                          ),
                                          if (product.product.price <
                                              product.product.oldPrice)
                                            DiscountContainer(size,
                                                product.product.discount, true),
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
                                            product.product.name,
                                            style: tajawal.copyWith(
                                                fontSize: size.width / 28),
                                          ),
                                          Container(
                                            height: size.width / 10,
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Qty: ',
                                                  style: tajawal.copyWith(
                                                      fontSize:
                                                          size.width / 24),
                                                ),
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons
                                                        .indeterminate_check_box_outlined,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Text(
                                                  cartModel!.data
                                                      .cartItems[index].quantity
                                                      .toString(),
                                                  style: roboto.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.add_box_outlined,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (product.product.price !=
                                              product.product.oldPrice)
                                            Text(
                                              product.product.oldPrice
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: size.width / 30,
                                                  color: Colors.grey[700],
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationColor:
                                                      Colors.redAccent,
                                                  decorationThickness: 2),
                                            ),
                                          Text(
                                            '${product.product.price.toString()} EGP',
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
                        itemCount: cartModel!.data.cartItems.length),
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
                              Icons.report_gmailerrorred_rounded,
                              color: Colors.grey,
                            ),
                            Text(
                              'Your Order qualifies for FREE Shipping!',
                              style:
                                  tajawal.copyWith(fontSize: size.width / 32),
                            ),
                          ],
                        ),
                        Divider(),
                        RichText(
                          text: TextSpan(
                            text: 'Sub Total: ',
                            style: tajawalNormal.copyWith(
                              fontSize: size.width / 24,
                              color: Colors.grey,
                            ),
                            children: [
                              TextSpan(
                                text: '${cartModel!.data.subTotal} EGP',
                                style: tajawalNormal.copyWith(
                                  fontSize: size.width / 20,
                                  color: mainColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CupertinoButton(
                            color: Colors.green[400],
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                'proceed to checkout'.toUpperCase(),
                                style: TextStyle(fontSize: size.width / 26),
                              ),
                            ),
                            onPressed: () {}),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Apply coupon next step',
                          style:
                              tajawalNormal.copyWith(fontSize: size.width / 32),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
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

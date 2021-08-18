import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shopin/components/components/components.dart';
import 'package:shopin/models/shop_model/products_model.dart';
import 'package:shopin/shared/bloc/app_bloc/app_bloc.dart';
import 'package:shopin/shared/bloc/app_bloc/app_states.dart';
import 'package:shopin/style/colors.dart';
import 'package:shopin/style/fonts.dart';
import 'modal_bottom_sheet.dart';

class ProductScreen extends StatelessWidget {
  final ProductData productData;
  ProductScreen(this.productData);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Container(
                        height: size.width / 2.2,
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            width: double.infinity,
                            height: size.width / 1.4,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CarouselSlider(
                                items: List.generate(
                                  productData.images.length,
                                  (index) => CachedNetworkImage(
                                    imageUrl: productData.images[index],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                options: CarouselOptions(
                                    viewportFraction: 1,
                                    onPageChanged: (index, reason) {
                                      cubit.dotsIndex(index);
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (productData.discount != null &&
                          productData.discount > 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10),
                          child: DiscountContainer(
                              size, productData.discount, true),
                        ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: DotsIndicator(
                            decorator: DotsDecorator(
                              activeColor: mainColor,
                            ),
                            dotsCount: productData.images.length,
                            position: cubit.dotsPosition.toDouble(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: Colors.black12,
                      thickness: 1.5,
                      height: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productData.name,
                          style: tajawalNormal.copyWith(
                            fontSize: size.width / 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              '${productData.price.toString()}',
                              style: tajawalNormal.copyWith(
                                  fontSize: size.width / 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  color: mainColor),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            if (productData.discount != null &&
                                productData.discount > 0)
                              Text(
                                productData.oldPrice.toString(),
                                style: TextStyle(
                                    fontSize: size.width / 26,
                                    color: Colors.grey[700],
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red,
                                    decorationThickness: 3),
                              ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'All prices include VAT ',
                              style: tajawalNormal.copyWith(
                                  fontSize: size.width / 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45,
                                  letterSpacing: 1),
                            ),
                            InkWell(
                              onTap: () {
                                showCupertinoModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return modalBottomSheet(size);
                                    });
                              },
                              child: Text(
                                'Details',
                                style: tajawalNormal.copyWith(
                                    fontSize: size.width / 28,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    color: mainColor),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                        Text(
                          'FREE Shipping',
                          style: tajawalNormal.copyWith(
                            fontSize: size.width / 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          color: Colors.black12,
                          thickness: 1,
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey[200],
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Ship to ',
                            style: tajawalNormal.copyWith(
                              fontSize: size.width / 24,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'EGYPT',
                                style: tajawalNormal.copyWith(
                                  fontSize: size.width / 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Want it ',
                            style: tajawalNormal.copyWith(
                              fontSize: size.width / 24,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Tomorrow? ',
                                style: tajawalNormal.copyWith(
                                  fontSize: size.width / 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'Order before ',
                                style: tajawalNormal.copyWith(
                                  fontSize: size.width / 24,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: '11 PM ',
                                style: tajawalNormal.copyWith(
                                  fontSize: size.width / 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'Select Next Day Delivery on checkout',
                                style: tajawalNormal.copyWith(
                                  fontSize: size.width / 24,
                                  color: Colors.black,
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
                                  'add to cart'.toUpperCase(),
                                  style: TextStyle(fontSize: size.width / 26),
                                )),
                            onPressed: () {
                              cubit.setUserCart(productData.id);
                            }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: Text(
                      'Description',
                      style: tajawalNormal.copyWith(
                          fontSize: size.width / 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: Text(
                      productData.description,
                      style: tajawalNormal.copyWith(
                          fontSize: size.width / 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

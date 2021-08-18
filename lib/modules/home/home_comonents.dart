import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopin/components/components/components.dart';
import 'package:shopin/models/shop_model/categories_model.dart';
import 'package:shopin/models/shop_model/home_model.dart';
import 'package:shopin/models/shop_model/products_model.dart';
import 'package:shopin/modules/product_screen/product_screen.dart';
import 'package:shopin/shared/bloc/app_bloc/app_bloc.dart';
import 'package:shopin/style/colors.dart';
import 'package:shopin/style/fonts.dart';

var name = [
  "assets/applinces.png",
  "assets/beauty.png",
  "assets/electronic.png",
  "assets/fashion.png",
  "assets/grocery.png",
  "assets/mobiles.png",
  "assets/sports_and_more.png",
  "assets/toys_and_babby.png",
  "assets/home.png"
];

Widget searchContainer() {
  return Container(
    height: 60,
    color: mainColor,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: TextFormField(
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            hintText: 'Search for Products, Brands and More',
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
          ),
          onTap: () {},
        ),
      ),
    ),
  );
}

//

Widget categoriesList(size, CategoriesModel categories) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6),
    height: size.width / 5.5,
    child: ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: categories.data.data.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: CachedNetworkImage(
                height: size.width / 8,
                fit: BoxFit.fill,
                imageUrl: categories.data.data[index].image,
              ),
            ),
            Text(
              categories.data.data[index].name,
              style: tajawal.copyWith(
                  fontSize: size.width / 32, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: 5,
        );
      },
    ),
  );
}

//

Widget bigBannerList(size, HomeModel banners) {
  return CarouselSlider(
    items: List.generate(
      banners.data.banners.length,
      (index) => Container(
        height: size.width / 2,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: banners.data.banners[index].image,
        ),
      ),
    ),
    options: CarouselOptions(
      aspectRatio: 2 / 1,
      height: size.width / 2,
      autoPlay: true,
      viewportFraction: 0.9,
    ),
  );
}

//

Widget saleItemsRow(
    size, List<ProductData> products, bool horizontal, AppCubit cubit) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 4),
    height: size.width / 1.8,
    child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: horizontal ? Axis.horizontal : Axis.vertical,
        itemBuilder: (context, index) {
          var product = products[index];
          return Stack(
            alignment: Alignment.topRight,
            children: [
              InkWell(
                onTap: () {
                  navigateTo(
                    context,
                    ProductScreen(
                      product,
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: size.width / 2.5,
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          height: size.width / 2.4,
                          imageUrl: products[index].image,
                        ),
                        Spacer(),
                        Text(
                          products[index].name,
                          maxLines: 1,
                          style: tajawal.copyWith(
                              fontSize: size.width / 28,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              products[index].price.toString(),
                              style: tajawal.copyWith(
                                  fontSize: size.width / 28,
                                  fontWeight: FontWeight.bold,
                                  color: mainColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              products[index].oldPrice.toString(),
                              style: TextStyle(
                                  fontSize: size.width / 36,
                                  color: Colors.grey[700],
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.red,
                                  decorationThickness: 2),
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
                onPressed: () {
                  cubit.setFavorites(product: product);

                },
                icon: Icon(
                  Icons.favorite,
                  color: product.inFavorites ? Colors.red: Colors.grey,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: DiscountContainer(size, products[index].discount, false),
              )
            ],
          );
        },
        itemCount: products.length),
  );
}

//

Widget dealsOfTheDay(size, List<ProductData> topProducts, context) {
  return Stack(
    alignment: Alignment.topCenter,
    children: [
      Container(
        height: size.width / 2,
        decoration: BoxDecoration(
          color: pinkColor,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      Container(
        width: double.infinity,
        alignment: Alignment.topCenter,
        child: Image.asset(
          'assets/banner_three.png',
          fit: BoxFit.cover,
        ),
      ),
      Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Top Discounts Of The Day',
                      style: tajawal.copyWith(
                        fontSize: size.width / 20,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'View All',
                        style: tajawal.copyWith(
                          fontSize: size.width / 28,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            width: double.infinity,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: GridView.count(
                shrinkWrap: true,
                childAspectRatio: 0.74,
                crossAxisSpacing: 10,
                padding: const EdgeInsets.all(6),
                physics: BouncingScrollPhysics(),
                children: List.generate(topProducts.length, (index) {
                  return InkWell(
                    onTap: () {
                      navigateTo(
                        context,
                        ProductScreen(
                          topProducts[index],
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                height: size.width / 3,
                                imageUrl: topProducts[index].image,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 2),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 6),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.75),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                '${topProducts[index].oldPrice - topProducts[index].price} EGP OFF',
                                style: tajawal.copyWith(
                                    fontSize: size.width / 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                            )
                          ],
                        ),
                        Text(
                          topProducts[index].name,
                          style: tajawal.copyWith(
                              fontSize: size.width / 28,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  );
                }),
                crossAxisCount: topProducts.length > 3 ? 2 : topProducts.length,
              ),
            ),
          )
        ],
      )
    ],
  );
}

//

Widget featureContainer(size) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.all(0),
    padding: const EdgeInsets.only(left: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      boxShadow: [
        BoxShadow(
            offset: Offset(0, 1),
            color: Colors.black26,
            spreadRadius: 0.3,
            blurRadius: 0)
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Text(
            'Featured Brand',
            style: tajawal.copyWith(
              fontSize: size.width / 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          child: Text(
            'Sponsored',
            style:
                tajawal.copyWith(fontSize: size.width / 24, color: Colors.grey),
          ),
        ),
        Image.asset(
          'assets/power_bank.png',
          fit: BoxFit.cover,
        )
      ],
    ),
  );
}

//

Widget saleContainer() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    margin: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      children: [
        Expanded(
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              'assets/running.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              "assets/laptop.png",
              fit: BoxFit.fill,
            ),
          ),
        )
      ],
    ),
  );
}

//

Widget dualCamera(size) {
  return Stack(
    children: [
      Container(
        height: size.width / 1.6,
        decoration: BoxDecoration(
          color: brownColor,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      Container(
        width: double.infinity,
        alignment: Alignment.topCenter,
        child: Image.asset(
          'assets/banner_two.png',
          fit: BoxFit.cover,
        ),
      ),
      Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dual Camera Phones',
                    style: tajawal.copyWith(fontSize: size.width / 18)),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'View All',
                        style: tajawal.copyWith(
                          fontSize: size.width / 28,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            width: double.infinity,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            width: double.infinity,
            height: size.width / 1.4,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: GridView.count(
                childAspectRatio: 0.5,
                padding: EdgeInsets.all(10),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(2, (index) {
                  return Column(
                    children: [
                      Container(
                        height: size.width / 2,
                        child: Image.asset(
                          'assets/phone_three.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Redmi Note 7s',
                          style: tajawal.copyWith(
                            fontSize: size.width / 22,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          'Trending Range',
                          style: tajawal.copyWith(
                              fontSize: size.width / 28, color: Colors.green),
                        ),
                      )
                    ],
                  );
                }),
              ),
            ),
          )
        ],
      ),
    ],
  );
}

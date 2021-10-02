import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopin/models/shop_model/cart_model.dart';
import 'package:shopin/models/shop_model/categories_model.dart';
import 'package:shopin/models/shop_model/favorite_model.dart';
import 'package:shopin/models/shop_model/home_model.dart';
import 'package:shopin/models/shop_model/products_model.dart';
import 'package:shopin/models/user_model/user_model.dart';
import 'package:shopin/modules/all_products/all_products.dart';
import 'package:shopin/modules/favorites/favorites_screen.dart';
import 'package:shopin/modules/home/home_screen.dart';
import 'package:shopin/modules/search/search_screen.dart';
import 'package:shopin/modules/user/profile/profile_screen.dart';

List<Widget> navScreens = [
  HomeScreen(),
  AllProductsScreen(),
  SearchScreen(),
  FavoritesScreen(),
  ProfileScreen(),
];

String? token;
String tokenKey = 'token';
UserModel? userModel;
CartModel? cartModel;
HomeModel? homeModel;
CategoriesModel? categoriesModel;
ProductsModel? productsModel;
ProductsModel? searchProduct;
FavoritesModel? favoritesProduct;
List<ProductData>? saleProducts = [];
List<ProductData>? topSaleProducts = [];
///TODO: ADD YOUR API
String shopUrl = 'https://student.valuxapps.com/api/';
String vat =
    'Value-Added Tax \n \nAs per Egyptian Tax regulations, VAT is charged at 14% on orders sold '
    'and shipped by ShopIN within the Egypt. The advertised prices for products displayed at ShopIN '
    'are inclusive of any VAT in accordance with the Egypt VAT law.\nIf your order contains items from a '
    'FBS (Fulfilled by ShopIN) Seller or any other Marketplace Seller, it is the requirement of the Seller'
    ' to charge any VAT if they are registered. Marketplace Sellers not exceeding the Egypt VAT '
    'registration threshold shall not issue a Tax Invoice and charge VAT on their sales';

import 'dart:core';

class HomeModel {
  late bool status;
  dynamic message;
  late HomeData data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = HomeData.fromJson(json['data']);
  }
}

class HomeData {
  late List<Banners> banners = [];
  late List<Products> products = [];
  late String ad;

  HomeData.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((v) {
      banners.add(Banners.fromJson(v));
    });

    json['products'].forEach((v) {
      products.add(Products.fromJson(v));
    });

    ad = json['ad'];
  }
}

class Banners {
  late int id;
  late String image;
  dynamic product;

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    product = json['product'];
  }
}

class Products {
  late int id;
  late var price;
  late var oldPrice;
  late var discount;
  late String image;
  late String name;
  late String description;
  late List<String> images = [];
  late bool inFavorites;
  late bool inCart;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}

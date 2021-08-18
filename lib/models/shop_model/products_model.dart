class ProductsModel {
  late bool status;
  dynamic message;
  late Data data;

  ProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late int currentPage;
  late List<ProductData> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

    json['data'].forEach((v) {
      data.add(ProductData.fromJson(v));
    });
  }
}

class ProductData {
  late int id;
  var price;
  var oldPrice;
  var discount;
  late String image;
  late String name;
  late String description;
  late List<String> images = [];
  late bool inFavorites;
  late bool inCart;

  ProductData.fromJson(Map<String, dynamic> json) {
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

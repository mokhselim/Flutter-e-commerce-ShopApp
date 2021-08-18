class FavoritesModel {
  late bool status;
  dynamic message;
  late FavoriteData data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = FavoriteData.fromJson(json['data']);
  }
}

class FavoriteData {
  late int currentPage;
  late List<Data> data = [];

  late dynamic total;

  FavoriteData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

    json['data'].forEach((v) {
      data.add(new Data.fromJson(v));
    });

    total = json['total'];
  }
}

class Data {
  late int id;
  late Product product;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json['product']);
  }
}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}

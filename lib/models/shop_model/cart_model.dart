class CartModel {
  late bool status;
  dynamic message;
  late Data data;

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  List<CartItems> cartItems = [];
  late dynamic subTotal;
  late dynamic total;

  Data.fromJson(Map<String, dynamic> json) {
    json['cart_items'].forEach((v) {
      cartItems.add(CartItems.fromJson(v));
    });

    subTotal = json['sub_total'];
    total = json['total'];
  }
}

class CartItems {
  late int id;
  late int quantity;
  late Product product;

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = Product.fromJson(json['product']);
  }
}

class Product {
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

  Product.fromJson(Map<String, dynamic> json) {
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


class CategoriesModel {
  late bool status;
  dynamic message;
  late CategoriesData data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = CategoriesData.fromJson(json['data']);
  }
}

class CategoriesData {
  late int currentPage;
  late List<Data> data = [];

  CategoriesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((v) {
      data.add(
        new Data.fromJson(v),
      );
    });
  }
}

class Data {
  late int id;
  late String name;
  late String image;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}

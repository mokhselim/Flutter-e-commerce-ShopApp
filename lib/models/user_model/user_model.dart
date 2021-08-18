class UserModel {
  late bool status;
  late String message;
  late RegisterUserData? data;

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']??'';
    data = json['data'] == null ? null : RegisterUserData.fromJson(json['data']);
  }
}

 class RegisterUserData {
  late String name;
  late String phone;
  late String email;
  late int id;
  late String image;
  late String token;
  dynamic points;
  dynamic credit;

  RegisterUserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
    points = json['points'];
    credit = json['credit'];
  }
}



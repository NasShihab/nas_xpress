import '../../model/user_info_model.dart';

class UserInfoSingleton {
  static final UserInfoSingleton _singleton = UserInfoSingleton._internal();

  factory UserInfoSingleton() {
    return _singleton;
  }

  UserInfoSingleton._internal();

  String? name;
  String? age;
  String? address1;
  String? city;
  String? gender;
  String? phone;
  String? role;

  void updateFromModel(UserInfoModel model) {
    name = model.name;
    age = model.age;
    address1 = model.address1;
    city = model.city;
    gender = model.gender;
    phone = model.phone;
    role = model.role;
  }
}

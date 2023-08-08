class UserInfoSingleton {
  static final UserInfoSingleton _singleton = UserInfoSingleton._internal();

  factory UserInfoSingleton() {
    return _singleton;
  }

  UserInfoSingleton._internal();

  String? name;
  int? age;
  String? address1;
  String? city;
  String? gender;
  String? phone;
  String? role;
}

import 'dart:convert';

import 'package:processmanagement/Model/Role.dart';
import 'package:processmanagement/Model/User.dart';

class LoginUserData {
  User user;
  final Role role;

  LoginUserData({
    this.role,
    this.user,
  });

  factory LoginUserData.fromRawJson(String str) =>
      LoginUserData.fromJson(json.decode(str));

  factory LoginUserData.fromJson(Map<String, dynamic> json) => LoginUserData(
      role: Role.fromJson(json["role"]), user: User.fromJson(json['user']));
}

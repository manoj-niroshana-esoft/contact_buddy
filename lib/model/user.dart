import 'dart:core';

class User {
  final int? id;
  final String name;
  final String? email;
  final String? password;
  User(
      {this.id,
      required this.name,
      required this.email,
      required this.password});
  User.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        password = res["password"],
        email = res["email"];
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}

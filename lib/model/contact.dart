import 'dart:core';

class Contact {
  final int? id;
  final String name;
  final String? email;
  final String? phoneNo;
  final String? company;
  Contact(
      {this.id,
      required this.name,
      required this.email,
      required this.phoneNo,
      required this.company});
  Contact.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        email = res["email"],
        phoneNo = res["phoneNo"],
        company = res["company"];
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNo': phoneNo,
      'company': company,
    };
  }
}

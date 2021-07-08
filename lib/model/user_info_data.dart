import 'dart:convert';

class UserInfoData {
  String id;
  String name;
  String mobile;
  String email;
  String phothUrl;
  UserInfoData({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.phothUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'email': email,
      'phothUrl': phothUrl,
    };
  }

  factory UserInfoData.fromMap(Map<String, dynamic> map) {
    return UserInfoData(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      mobile: map['mobile'] ?? '',
      email: map['email'] ?? '',
      phothUrl: map['phothUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfoData.fromJson(String source) =>
      UserInfoData.fromMap(json.decode(source));
}

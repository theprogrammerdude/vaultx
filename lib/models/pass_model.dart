// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PassModel {
  String url;
  String username;
  String password;
  int createdAt;
  String id;

  PassModel({
    required this.url,
    required this.username,
    required this.password,
    required this.createdAt,
    required this.id,
  });

  PassModel copyWith({
    String? url,
    String? username,
    String? password,
    int? createdAt,
    String? id,
  }) {
    return PassModel(
      url: url ?? this.url,
      username: username ?? this.username,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'username': username,
      'password': password,
      'createdAt': createdAt,
      'id': id,
    };
  }

  factory PassModel.fromMap(Map<String, dynamic> map) {
    return PassModel(
      url: map['url'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      createdAt: map['createdAt'] as int,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PassModel.fromJson(String source) =>
      PassModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PassModel(url: $url, username: $username, password: $password, createdAt: $createdAt, id: $id)';
  }

  @override
  bool operator ==(covariant PassModel other) {
    if (identical(this, other)) return true;

    return other.url == url &&
        other.username == username &&
        other.password == password &&
        other.createdAt == createdAt &&
        other.id == id;
  }

  @override
  int get hashCode {
    return url.hashCode ^
        username.hashCode ^
        password.hashCode ^
        createdAt.hashCode ^
        id.hashCode;
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class UserModel extends Equatable {
  final String? uid;
  final String? name;
  final String? email;
  final String? phoneNumber;

  const UserModel({
    this.uid,
    this.name,
    this.email,
    this.phoneNumber,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? phoneNumber,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
    );
  }

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        phoneNumber,
      ];
}

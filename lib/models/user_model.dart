import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_multi_formatter/utils/enum_utils.dart';

enum GenderType {
  man,
  woman,
}

@immutable
class UserModel extends Equatable {
  final String? uid;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final GenderType? genderType;
  final DateTime? birthday;

  const UserModel({
    this.uid,
    this.name,
    this.email,
    this.phoneNumber,
    this.genderType,
    this.birthday,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? phoneNumber,
    GenderType? genderType,
    DateTime? birthday,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      genderType: genderType ?? this.genderType,
      birthday: birthday ?? this.birthday,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'genderType': enumToString(genderType),
      'birthday': birthday != null ? Timestamp.fromDate(birthday!) : null,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      genderType: enumFromString(
        GenderType.values,
        json['genderType'],
      ),
      birthday: json['birthday'] != null ? json['birthday'].toDate() : null,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        phoneNumber,
        genderType,
      ];
}

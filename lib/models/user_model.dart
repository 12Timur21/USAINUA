import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_multi_formatter/utils/enum_utils.dart';
import 'package:usainua/utils/constants.dart';

@immutable
class UserModel extends Equatable {
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      genderType: GenderType.values[0].enumFromString(
        json['genderType'],
      ),
      birthday: json['birthday'] != null ? json['birthday'].toDate() : null,
    );
  }

  const UserModel({
    this.uid,
    this.name,
    this.email,
    this.phoneNumber,
    this.genderType,
    this.birthday,
  });

  final String? uid;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final GenderType? genderType;
  final DateTime? birthday;

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
      'genderType': genderType?.displayTitle,
      'birthday': birthday != null ? Timestamp.fromDate(birthday!) : null,
    };
  }

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        phoneNumber,
        genderType,
        birthday,
      ];
}

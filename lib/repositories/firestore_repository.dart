import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:usainua/models/payment_card_model.dart';
import 'package:usainua/models/product_model.dart';
import 'package:usainua/models/user_model.dart';
import 'package:usainua/repositories/auth_repository.dart';
import 'package:uuid/uuid.dart';

class FirestoreRepository {
  FirestoreRepository._();
  static final FirestoreRepository instance = FirestoreRepository._();

  final CollectionReference _ordersCollection =
      FirebaseFirestore.instance.collection('orders');
  final CollectionReference _paymentCardCollection =
      FirebaseFirestore.instance.collection('payment_cards');

  //? [START] User management
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser(UserModel userModel) async {
    await _userCollection.doc(userModel.uid).set(
          userModel.toJson(),
        );
  }

  Future<UserModel?> getUserByUid(String uid) async {
    final docSnapshot = await _userCollection.doc(uid).get();
    Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
    if (data != null) {
      return UserModel.fromJson(data);
    }
    return null;
  }

  Future<void> updateUser({
    required UserModel userModel,
  }) async {
    print('gere');
    String? uid = AuthRepository.instance.uid;
    await _userCollection.doc(uid).update(
          userModel.toJson(),
        );
  }

  void deleteUser() {
    _userCollection.doc().delete();
  }
//? [End] User management

  //? [START] Payment cards
  Future<void> saveUserPaymentCard({
    required PaymentCardModel paymentCardModel,
  }) async {
    String? uid = AuthRepository.instance.uid;

    await _paymentCardCollection.doc(uid).set(
      {
        'creditCards': FieldValue.arrayUnion([
          paymentCardModel.toJson(),
        ]),
      },
      SetOptions(
        merge: true,
      ),
    );
  }

  Future<void> setAutomaticWriteOffStatus(bool status) async {
    String? uid = AuthRepository.instance.uid;
    await _paymentCardCollection.doc(uid).set(
      {
        'isAutomaticWriteOff': status,
      },
      SetOptions(
        merge: true,
      ),
    );
  }

  Future<bool?> getAutomaticWriteOffStatus() async {
    String? uid = AuthRepository.instance.uid;
    DocumentSnapshot snapshot = await _paymentCardCollection.doc(uid).get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    return data?['isAutomaticWriteOff'];
  }

  Future<void> setActivePaymentCardID(String? id) async {
    String? uid = AuthRepository.instance.uid;
    await _paymentCardCollection.doc(uid).set(
      {
        'activePaymentCard': id,
      },
      SetOptions(
        merge: true,
      ),
    );
  }

  Future<String?> getActivePaymentCardID() async {
    String? uid = AuthRepository.instance.uid;
    DocumentSnapshot snapshot = await _paymentCardCollection.doc(uid).get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    return data?['activePaymentCard'];
  }

  Future<List<PaymentCardModel>?> getAllPaymentCards() async {
    String? uid = AuthRepository.instance.uid;
    List<PaymentCardModel>? paymentCardModels = [];
    DocumentSnapshot snapshot = await _paymentCardCollection.doc(uid).get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    List<dynamic>? creditCards = data?['creditCards'];

    creditCards?.forEach((element) {
      paymentCardModels.add(
        PaymentCardModel.fromJson(
          element,
        ),
      );
    });
    return paymentCardModels;
  }

  //? [End] Payment cards

  //? [START] Product
  Future<void> createProduct({
    required List<ProductModel> productModelList,
  }) async {
    String? uid = AuthRepository.instance.uid;
    for (ProductModel element in productModelList) {
      _ordersCollection
          .doc(uid)
          .collection('allOrders')
          .doc(
            element.id,
          )
          .set(
            element.toJson(),
          );
    }
  }
  //? [End] Product

}

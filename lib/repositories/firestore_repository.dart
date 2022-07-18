import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:usainua/models/payment_card_model.dart';
import 'package:usainua/models/order_model.dart';
import 'package:usainua/models/recipient_address_model.dart';
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
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _recipientAddressCollection = FirebaseFirestore
      .instance
      .collection('recipient_address')
      .doc(AuthRepository.instance.uid)
      .collection(
        'all_recipient_address',
      );

  //? [START] User management

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
    String? uid = AuthRepository.instance.uid;
    await _userCollection.doc(uid).update(
          userModel.toJson(),
        );
  }

  void deleteUser() {
    _userCollection.doc().delete();
  }
//? [End] User management

//? [START] Recipient Address

  Future<void> saveRecipientAddressModel({
    required RecipentAddressModel recipentAddressModel,
  }) async {
    await _recipientAddressCollection.doc(recipentAddressModel.id).set(
          recipentAddressModel.toJson(),
        );
  }

  Future<void> deleteRecipientAddressModel({
    required String recipentAddressID,
  }) async {
    await _recipientAddressCollection.doc(recipentAddressID).delete();
  }

  Future<List<RecipentAddressModel>> getAllRecipientAddressModels() async {
    List<RecipentAddressModel> recipientAdressModels = [];
    QuerySnapshot querySnapshot = await _recipientAddressCollection.get();
    List<QueryDocumentSnapshot> queryDocumentSnapshots = querySnapshot.docs;

    for (QueryDocumentSnapshot? element in queryDocumentSnapshots) {
      final mapElement = element?.data() as Map<String, dynamic>?;
      if (mapElement != null) {
        recipientAdressModels.add(
          RecipentAddressModel.fromJson(mapElement),
        );
      }
    }
    return recipientAdressModels;
  }

  Future<void> updateRecipientAddressModel({
    required RecipentAddressModel recipentAddressModel,
  }) async {
    await _recipientAddressCollection.doc(recipentAddressModel.id).update(
          recipentAddressModel.toJson(),
        );
  }

  Future<void> updateSelectedRecipientAddressModel({
    required String? recipentAddressID,
  }) async {
    FirebaseFirestore.instance
        .collection('recipient_address')
        .doc(AuthRepository.instance.uid)
        .collection('additional')
        .doc('settings')
        .set(
      {
        'selected_item_id': recipentAddressID,
      },
      SetOptions(merge: true),
    );
  }

  Future<String?> getSelectedRecipientAddressModel() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('recipient_address')
        .doc(AuthRepository.instance.uid)
        .collection('additional')
        .doc('settings')
        .get();

    final mapElement = documentSnapshot.data() as Map<String, dynamic>?;
    return mapElement?['selected_item_id'];
  }

  //? [End] Recipient Address

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

  //? [START] Orders
  Future<void> createOrder({
    required List<OrderModel> orderModels,
  }) async {
    for (OrderModel element in orderModels) {
      await _ordersCollection
          .doc(AuthRepository.instance.uid)
          .collection('allOrders')
          .doc(
            element.id,
          )
          .set(
            element.toJson(),
          );
    }
  }

  Future<List<OrderModel>> getAllOrders() async {
    List<OrderModel> orderModels = [];
    QuerySnapshot querySnapshot = await _ordersCollection
        .doc(
          AuthRepository.instance.uid,
        )
        .collection('allOrders')
        .get();

    List<QueryDocumentSnapshot> listQuerySnapshots = querySnapshot.docs;

    for (QueryDocumentSnapshot querySnapshot in listQuerySnapshots) {
      final json = querySnapshot.data() as Map<String, dynamic>?;
      if (json != null) {
        orderModels.add(
          OrderModel.fromJson(
            json,
          ),
        );
      }
    }

    return orderModels;
  }

  Future<void> deleteOrder({
    required String orderID,
  }) async {
    await _ordersCollection
        .doc(AuthRepository.instance.uid)
        .collection('allOrders')
        .doc(
          orderID,
        )
        .delete();
  }

  //? [End] Orders

}

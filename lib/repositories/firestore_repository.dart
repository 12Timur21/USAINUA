import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:usainua/models/product_model.dart';
import 'package:usainua/models/user_model.dart';
import 'package:usainua/repositories/auth_repository.dart';

class FirestoreRepository {
  FirestoreRepository._();
  static final FirestoreRepository instance = FirestoreRepository._();

  final CollectionReference _ordersCollection =
      FirebaseFirestore.instance.collection(
    'orders',
  );

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
    String? name,
    String? email,
    String? phoneNumber,
  }) async {
    Map<String, dynamic> updatedData = {};

    if (name != null) {
      updatedData['name'] = name;
    }

    if (email != null) {
      updatedData['email'] = email;
    }

    if (phoneNumber != null) {
      updatedData['phoneNumber'] = phoneNumber;
    }

    await _userCollection.doc().update(updatedData);
  }

  void deleteUser() {
    _userCollection.doc().delete();
  }
  //? [End] User management

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
}

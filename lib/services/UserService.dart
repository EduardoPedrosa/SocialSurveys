import 'package:SocialSurveys/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final CollectionReference _collection =
      Firestore.instance.collection("Users");

  UserService._privateConstructor();
  static final UserService instance = UserService._privateConstructor();

  Future<void> addUser(String userId, String email, String name) async {
    User user = new User(email: email, name: name);
    await _collection.document(userId).setData(user.toJson());
  }

  Future<User> getUser(String userId) async {
    DocumentSnapshot snapshot = await _collection.document(userId).get();
    return User.fromMap(snapshot);
  }
}

import 'package:SocialSurveys/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final CollectionReference _collection = Firestore.instance.collection("Usuarios");

  UserService._privateConstructor();
  static final UserService instance = UserService._privateConstructor();

  void addUser(String userId, String email, String name) async {
    User user = User(email: email, name: name);
    print(userId);
    await _collection.document(userId).setData(user.toJson());
  }
  
  Future<User> getUser(String userId) async {
    DocumentSnapshot snapshot = await _collection.document(userId).get();
    return User.fromMap(snapshot);
  }
}
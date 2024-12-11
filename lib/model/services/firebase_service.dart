import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garduationproject/model/user_model/user_model.dart';

class DatabaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveUser(UserModel user) async {
    String collection = user.userType == 'Doctor' ? 'doctors' : 'parents';
    await firestore.collection(collection).doc(user.email).set(user.toJson());
  }
}

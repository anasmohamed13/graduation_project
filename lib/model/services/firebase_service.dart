import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garduationproject/model/user_model/user_model.dart';

//comment to Gana this code to save user data in firestore
//but the doctor have collection and parent have another collection
class DatabaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveUser(UserModel user) async {
    String collection = user.userType == 'Doctor' ? 'Doctors' : 'Parents';
    await firestore.collection(collection).doc(user.email).set(user.toJson());
  }
}

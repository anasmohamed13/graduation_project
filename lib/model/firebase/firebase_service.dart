// ignore_for_file: avoid_print, unused_local_variable, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garduationproject/model/doctor_model/doctor_model.dart';
import 'package:garduationproject/model/parent_model/parent_model.dart';

//comment to Gana this code to save user data in firestore
//but the doctor have collection and parent have another collection
class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  //-------------- to Ganna its not complete and have a Bug---------------//
  // Future<void> updateUserField(String field, String value) async {
  //   try {
  //     String? userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId != null) {
  //       await FirebaseFirestore.instance
  //           .collection('Parents')
  //           .doc(userId)
  //           .update({field: value});
  //       print("$field updated to $value");
  //     }
  //   } catch (e) {
  //     print("Error updating $field: $e");
  //     throw Exception("Failed to update $field: $e");
  //   }
  // }

  Future<bool> checkDoctorExistsByEmail(String email) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Doctor')
        .where('email', isEqualTo: email)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  Future<void> saveUser({
    required String userType,
    required Map<String, dynamic> userData,
    required String email,
  }) async {
    String collection = userType == 'Doctor' ? 'Doctors' : 'Parents';
    await firestore.collection(collection).doc(email).set(userData);
  }

  Future<void> saveDoctor(DoctorModel doctor) async {
    await firestore.collection('Doctor').doc(doctor.email).set(doctor.toJson());
  }

  Future<void> saveParent(ParentModel parent) async {
    await firestore.collection('Parent').doc(parent.email).set(parent.toJson());
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<dynamic> fetchUserData() async {
    try {
      final User? user = auth.currentUser;
      if (user != null) {
        String collection = await getUserCollection(user.email!);
        if (collection == 'Doctors') {
          DocumentSnapshot snapshot =
              await firestore.collection('Doctors').doc(user.email).get();
          if (snapshot.exists) {
            return DoctorModel.fromJson(
                snapshot.data() as Map<String, dynamic>);
          }
        } else if (collection == 'Parents') {
          DocumentSnapshot snapshot =
              await firestore.collection('Parents').doc(user.email).get();
          if (snapshot.exists) {
            return ParentModel.fromJson(
                snapshot.data() as Map<String, dynamic>);
          }
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
    return null;
  }

  Future<String> getUserCollection(String email) async {
    try {
      // check this email in doctor collection (comment to ganna)
      DocumentSnapshot doctorSnapshot =
          await firestore.collection('Doctors').doc(email).get();
      if (doctorSnapshot.exists) {
        return 'Doctors';
      }

      // check this email in Parent collection (comment to ganna)
      DocumentSnapshot parentSnapshot =
          await firestore.collection('Parents').doc(email).get();
      if (parentSnapshot.exists) {
        return 'Parents';
      }
    } catch (e) {
      print('Error determining user collection: $e');
    }
    return ''; // if the user not found in any collection
  }
}

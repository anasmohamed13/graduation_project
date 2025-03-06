// ignore_for_file: avoid_print, unused_local_variable, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garduationproject/model/user_model/user_model.dart';

//comment to Gana this code to save user data in firestore
//but the doctor have collection and parent have another collection
class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  UserModel? userData;

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

  Future<void> saveUser(UserModel user) async {
    String collection = user.userType == 'Doctor' ? 'Doctors' : 'Parents';
    await firestore.collection(collection).doc(user.email).set(user.toJson());
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<UserModel?> fetchUserData() async {
    try {
      //get current user (read this ganna)
      final User? user = auth.currentUser;
      if (user != null) {
        // تحديد اسم الـ Collection بناءً على نوع المستخدم
        String collection = await getUserCollection(user.email!);

        if (collection.isNotEmpty) {
          // to ganna this to read data from firestore
          DocumentSnapshot snapshot =
              await firestore.collection(collection).doc(user.email).get();

          if (snapshot.exists) {
            return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
          }
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
    return null;
  }

  // ميثود لتحديد Collection بناءً على البريد الإلكتروني
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

//------------->will deleted or fixed <------------
  // Future<void> signInWithGoogle(BuildContext context) async {
  //   try {
  //     GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     if (googleUser == null) return; // when User canceled sign-in (to Ganna)
  //     GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

  //     AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //     User? firebaseUser = userCredential.user;
  //     if (firebaseUser != null) {
  //       // Fetch user data from Firestore
  //       UserModel? userModel = await fetchUserData();

  //       if (userModel != null) {
  //         // Navigate to the correct profile based on userType
  //         navigateToProfile(context, userModel.userType);
  //       } else {
  //         UserModel newUser = UserModel(
  //           fullName: firebaseUser.displayName ?? '',
  //           email: firebaseUser.email ?? '',
  //           phoneNumber: firebaseUser.phoneNumber ?? '',
  //           userType: 'Parent',
  //           medicalLicenseNumber: null,
  //           MedicalSpecializatin: null,
  //         );
  //         await saveUser(newUser);

  //         navigateToProfile(context, newUser.userType);
  //       }
  //     }

  //     // complete this method to save user and navigate to profile
  //     // create method to sign in via phone}
  //   } catch (e) {
  //     print('Error signing in with Google: $e');
  //   }
  // }
}

//will deleted
// void navigateToProfile(BuildContext context, String userType) {
//   if (userType == UserModel.collectionDoctor) {
//     Navigator.pushReplacementNamed(context, ProfileDoctor.routeName);
//   } else if (userType == UserModel.collectionParent) {
//     Navigator.pushReplacementNamed(context, ProfileParent.routeName);
//   } else {
//     print('Unknown user type: $userType');
//   }
// }

// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garduationproject/model/user_model/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

//comment to Gana this code to save user data in firestore
//but the doctor have collection and parent have another collection
class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  UserModel? userData;

  Future<void> saveUser(UserModel user) async {
    String collection = user.userType == 'Doctor' ? 'Doctors' : 'Parents';
    await firestore.collection(collection).doc(user.email).set(user.toJson());
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
//------->fixed another time(to Ganna)<-----------------
  // Future<UserCredential?> signInWithFacebook() async {
  //   final LoginResult result = await FacebookAuth.instance.login();
  //   if (result.status == LoginStatus.success) {
  //     // Create a credential from the access token
  //     final OAuthCredential credential =
  //         FacebookAuthProvider.credential(result.accessToken!.tokenString);
  //     // Once signed in, return the UserCredential
  //     return await FirebaseAuth.instance.signInWithCredential(credential);
  //   }
  //   return null;
  // }
  // Future<void> signInWithFacebook() async {
  //   final LoginResult result = await FacebookAuth.instance.login();
  //   try {
  //     // Check if the login was successful
  //     if (result.status == LoginStatus.success) {
  //       // Get the access token
  //       final AccessToken accessToken = result.accessToken!;

  //       // Create a credential from the access token
  //       final OAuthCredential credential =
  //           FacebookAuthProvider.credential(accessToken.tokenString);

  //       // Sign in to Firebase with the credential
  //       final UserCredential userCredential =
  //           await auth.signInWithCredential(credential);

  //       // Get the user data from Facebook
  //       final Map<String, dynamic> userData =
  //           await FacebookAuth.instance.getUserData();

  //       // Create a UserModel object
  //       UserModel user = UserModel(
  //         email: userCredential.user!.email ?? '',
  //         fullName: userData['name'] ?? '',
  //         userType: 'Parent',
  //         phoneNumber: '', // Default to 'Parent' or adjust as needed
  //       );

  //       // Save the user data to Firestore
  //       await saveUser(user);

  //       //   // Successfully signed in
  //       //   print('Signed in: ${userCredential.user!.displayName}');
  //       // } else {
  //       //   print('Facebook login failed: ${result.status}');
  //       // }
  //     }
  //   } catch (e) {
  //     print('Error signing in with Facebook: $e');
  //   }
  // }
  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

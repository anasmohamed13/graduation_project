import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ImagePicker picker = ImagePicker();

  /// Pick image and upload to Firestore under specified collection & doc ID
  Future<File?> pickAndUploadImage({
    required String collection,
    required String docId,
    required String imageFieldName,
  }) async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return null;

      final File selectedImage = File(image.path);
      final bytes = await selectedImage.readAsBytes();
      final base64Image = base64Encode(bytes);

      await firestore
          .collection(collection)
          .doc(docId)
          .update({imageFieldName: base64Image});

      return selectedImage;
    } catch (e) {
      rethrow; // Handle it at UI level
    }
  }

  /// Load saved image from Firestore as bytes
  Future<Uint8List?> loadImageBytes({
    required String collection,
    required String docId,
    required String imageFieldName,
  }) async {
    try {
      final doc = await firestore.collection(collection).doc(docId).get();
      if (!doc.exists || doc.data() == null) return null;

      final base64Image = doc.data()![imageFieldName];
      if (base64Image == null) return null;

      final bytes = base64Decode(base64Image);
      return bytes;
    } catch (e) {
      return null;
    }
  }
}

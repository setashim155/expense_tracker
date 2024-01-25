import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _profileImagesRef = FirebaseStorage.instance.ref('profileImages');

  Future<void> signUp({
    required XFile profileImage,
    required Map<String, dynamic> values,
  }) async {
    try {
      final response = await _auth.createUserWithEmailAndPassword(
        email: values['email'],
        password: values['password'],
      );

      // For profile pic
      final ref = _profileImagesRef.child(profileImage.name);
      await ref.putFile(File(profileImage.path));
      final photoUrl = await ref.getDownloadURL();

      // For user other info
      final user = response.user;
      await user?.updatePhotoURL(photoUrl);
      await user?.updateDisplayName(values['fullName']);
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<void> login({required Map<String, dynamic> values}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: values['email'],
        password: values['password'],
      );
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }
}

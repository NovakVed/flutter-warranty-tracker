import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_warranty_tracker/features/login/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<void> addProfilePicture(String profilePicturePath) async {
    try {
      String? name = _firebaseAuth.currentUser?.displayName;
      String? email = _firebaseAuth.currentUser?.email;
      if (name != null && email != null) {
        final storageRef =
            _firebaseStorage.ref().child('profile_picture').child('$email.jpg');

        await storageRef
            .putFile(File(profilePicturePath))
            .whenComplete(() async {
          final photoURL = await storageRef.getDownloadURL();

          await _firebaseFirestore
              .collection('users')
              .doc(email)
              .set({'photoURL': photoURL});
        });
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = UserModel(name: name, email: email);
      await _firebaseFirestore
          .collection('users')
          .doc(email)
          .set(user.toJson());
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<String?> getUser() async {
    return (_firebaseAuth.currentUser)?.email;
  }

  Future<String?> getUserDisplayName() async {
    final String? userUid = _firebaseAuth.currentUser?.email;
    if ((_firebaseAuth.currentUser)?.displayName != null) {
      final userModel =
          await _firebaseFirestore.collection('users').doc(userUid).get();
      return userModel['name'];
    }
    return (_firebaseAuth.currentUser)?.displayName;
  }
}

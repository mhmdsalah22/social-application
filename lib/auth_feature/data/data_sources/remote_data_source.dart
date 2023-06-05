import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_application/auth_feature/data/models/create_user_model.dart';
import 'package:social_application/core/error/failure.dart';

class RemoteDataSource {
  Future<UserCredential> loginUser(String email, String password) async {
    try {
      final result = FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return result;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      throw ServerFailure(message: e.code);
    }
  }

  Future<UserCredential> registerUser(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    try {
      final result = FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return result;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      throw ServerFailure(message: e.code);
    }
  }

  Future createUser(
      {required String name,
      required String email,
      required String phone,
      required String uId}) {
    try {
      SocialUserModel model = SocialUserModel(
          name: name,
          email: email,
          phone: phone,
          uId: uId,
          image:
              'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
          bio: 'Write your bio ....',
          cover:
              'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
          followers: [],
          following: []);
      final result = FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .set(model.toMap());
      return result;
    } catch (error) {
      print(error);
      throw ServerFailure(message: error.toString());
    }
  }

  Future resetPassword({required String email}) async {
    try {
      final result = FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return result;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw ServerFailure(message: e.message.toString());
    }
  }

  bool isEmailVerified = false;
  Timer? timer;

  Future verifyEmail() async {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    try {
      if (!isEmailVerified) {
        sendEmailVerification();
        timer = Timer.periodic(
            const Duration(
              seconds: 3,
            ),
            (timer) => checkEmailVerified());
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw ServerFailure(message: e.message.toString());
    }
  }

  Future sendEmailVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();
      print('check $isEmailVerified');
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw ServerFailure(message: e.message.toString());
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (isEmailVerified) timer?.cancel();
  }
}

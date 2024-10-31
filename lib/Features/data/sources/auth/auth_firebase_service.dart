import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/Features/data/models/user_model.dart';
import 'package:spotify/Features/domain/entities/user.dart';
import 'package:spotify/core/constants/app_urls.dart';
import '../../models/create_user_req.dart';
import '../../models/singin_user_req.dart';

abstract class FirebaseAuthService {
  Future<Either> signIn(SignInUserReq signInUserReq);

  Future<Either> signUp(CreateUserReq createUserReq);

  Future<Either> getUser();
}

class FirebaseAuthServiceImpl implements FirebaseAuthService {
  FirebaseAuthServiceImpl();

  @override
  Future<Either> signIn(SignInUserReq signInUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signInUserReq.email,
        password: signInUserReq.password,
      );

      return const Right('Logged In Successfully');
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'invalid-email') {
        log('The email is badly formatted.');
        message = 'The email is badly formatted.';
      } else if (e.code == 'invalid-credential') {
        log('The email is badly formatted.');
        message = 'The email is badly formatted.';
      } else if (e.code == 'user-not-found') {
        log('No user found for that email.');
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
        message = 'Wrong password provided for that user.';
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        message = 'The account already exists for that email.';
      }
      return Left(message);
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      var userData = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      UserModel userModel = UserModel.fromJson(userData.data()!);
      userModel.imageUrl = auth.currentUser!.photoURL ?? AppURLs.defaultImageUrl;
      UserEntity userEntity = userModel.toEntity();

      return Right(userEntity);
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(data.user!.uid)
          .set({
        'name': createUserReq.name,
        'email': createUserReq.email,
        'uid': data.user!.uid,
        'password': createUserReq.password,
        'createdAt': DateTime.now().toString(),
        'updatedAt': DateTime.now().toString(),
      });

      return const Right('Signed Up Successfully');
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        message = 'The account already exists for that email.';
      }
      return Left(message);
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }
}

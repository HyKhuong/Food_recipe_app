import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_recipe_app/data/models/user_req/login_req.dart';
import 'package:food_recipe_app/data/models/user_req/register_req.dart';
import 'package:food_recipe_app/data/models/user_req/user.dart';
import 'package:food_recipe_app/domain/entities/user.dart';

abstract class AuthFirebaseService {
  Future<Either> login(LoginReq userReq);
  Future<Either> register(RegisterReq userReq);
  Future<void> logout();
  Future<Either> getUser();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<Either> login(LoginReq userReq) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: userReq.email,
        password: userReq.password,
      );
      return const Right('Signin was successful');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user';
      } else {
        message = 'Signin failed: ${e.message}';
      }
      return Left(message);
    }
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either> register(RegisterReq userReq) async {
    if (userReq.email.isEmpty || userReq.password.isEmpty) {
      return Left('Email and password cannot be empty.');
    }

    try {
      var data = await _auth.createUserWithEmailAndPassword(
        email: userReq.email,
        password: userReq.password,
      );

      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set({
        'name': userReq.fullName,
        'email': data.user?.email,
      });
      return const Right('Signup was successful');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email';
      } else {
        message = 'Signup failed: ${e.message}';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore
          .collection('Users')
          .doc(firebaseAuth.currentUser?.uid)
          .get();

      UserModel userModel = UserModel.fromJson(user.data()!);
      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    } catch (e) {
      return const Left('An error has occurred');
    }
  }
}

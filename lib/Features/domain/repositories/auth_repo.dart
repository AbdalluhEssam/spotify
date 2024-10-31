import 'package:dartz/dartz.dart';
import '../../data/models/create_user_req.dart';
import '../../data/models/singin_user_req.dart';

abstract class AuthRepository {
  Future<Either> signIn(SignInUserReq signInUserReq);
  Future<Either> signUp(CreateUserReq createUserReq);
  Future<Either> getUser();
}
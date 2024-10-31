import 'package:dartz/dartz.dart';
import 'package:spotify/Features/data/models/create_user_req.dart';
import 'package:spotify/Features/domain/repositories/auth_repo.dart';
import '../../../../service_locator.dart';
import '../models/singin_user_req.dart';
import '../sources/auth/auth_firebase_service.dart';

class AuthRepositoryImpl implements AuthRepository {

  @override
  Future<Either> signIn(SignInUserReq signInUserReq) async{
    return await sl<FirebaseAuthService>().signIn(signInUserReq);
  }

  @override
  Future<Either> getUser() async{
    return await sl<FirebaseAuthService>().getUser();
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
   return await sl<FirebaseAuthService>().signUp(createUserReq);
  }
}

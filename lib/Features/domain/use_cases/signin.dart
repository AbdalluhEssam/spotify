import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import '../../../../service_locator.dart';
import '../../data/models/singin_user_req.dart';
import '../repositories/auth_repo.dart';

class SignInUseCase implements UseCase<Either,SignInUserReq>{
  @override
  Future<Either> call({SignInUserReq? params}) async{
    return await sl<AuthRepository>().signIn(params!);
  }
}
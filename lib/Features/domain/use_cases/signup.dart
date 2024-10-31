import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import '../../../../service_locator.dart';
import '../../data/models/create_user_req.dart';
import '../repositories/auth_repo.dart';

class SignUpUseCase implements UseCase<Either,CreateUserReq>{
  @override
  Future<Either> call({CreateUserReq? params}) async{
    return await sl<AuthRepository>().signUp(params!);
  }
}
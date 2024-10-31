import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import '../../../../service_locator.dart';
import '../repositories/auth_repo.dart';

class GetUserUseCase implements UseCase<Either,dynamic>{
  @override
  Future<Either> call({ params}) async{
    return await sl<AuthRepository>().getUser();
  }
}
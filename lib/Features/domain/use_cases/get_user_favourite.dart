import 'package:dartz/dartz.dart';
import 'package:spotify/Features/domain/repositories/song.dart';
import 'package:spotify/core/usecase/usecase.dart';
import '../../../../service_locator.dart';
import '../repositories/auth_repo.dart';

class GetUserFavouriteSongsUseCase implements UseCase<Either,dynamic>{
  @override
  Future<Either> call({ params}) async{
    return await sl<SongRepository>().getUserFavouriteSongs();
  }
}
import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repositories/song.dart';

class AddOrRemoveFavoriteUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongRepository>().addOrRemoveFavorite(params);
  }
}

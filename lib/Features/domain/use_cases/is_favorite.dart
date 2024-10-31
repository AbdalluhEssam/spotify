import 'package:spotify/core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repositories/song.dart';

class IsFavoriteUseCase implements UseCase<bool, String> {
  @override
  Future<bool> call({String? params}) async{
    return await sl<SongRepository>().isFavorite(params!);

  }

}

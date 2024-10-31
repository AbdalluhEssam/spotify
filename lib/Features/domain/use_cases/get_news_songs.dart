import 'package:dartz/dartz.dart';
import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repositories/song.dart';

class GetNewsSongsUseCase implements UseCase<Either,dynamic>{
  @override
  Future<Either> call({params}) async{
   return await sl<SongRepository>().getNewsSongs();
  }

}
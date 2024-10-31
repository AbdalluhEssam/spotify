import 'package:dartz/dartz.dart';
import 'package:spotify/Features/data/sources/songs/songs_firebase_service.dart';

import '../../../service_locator.dart';
import '../../domain/repositories/song.dart';

 class SongRepositoryImpl extends SongRepository {

  @override
  Future<Either> getNewsSongs()async {
    return await sl<SongFirebaseService>().getNewsSongs();
  }

  @override
  Future<Either> getPlayList() async{
    return await sl<SongFirebaseService>().getPlayList();

  }

  @override
  Future<Either> addOrRemoveFavorite(String songId) async{
    return await sl<SongFirebaseService>().addOrRemoveFavourite(songId);

  }

  @override
  Future<bool> isFavorite(String songId) async{
    return await sl<SongFirebaseService>().isFavorite(songId);

  }

  @override
  Future<Either> getUserFavouriteSongs() async{
    return await sl<SongFirebaseService>().getUserFavouriteSongs();

  }

}
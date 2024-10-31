import 'package:dartz/dartz.dart';

abstract class SongRepository {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavorite(String songId);
  Future<bool> isFavorite(String songId);
  Future<Either> getUserFavouriteSongs();
}
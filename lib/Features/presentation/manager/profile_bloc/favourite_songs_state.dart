part of 'favourite_songs_cubit.dart';

abstract class FavouriteSongsState {}

final class FavouriteSongsLoading extends FavouriteSongsState {}
final class FavouriteSongsLoaded extends FavouriteSongsState {
  List<SongEntity> songs;
  FavouriteSongsLoaded({required this.songs});
}
final class FavouriteSongsFailure extends FavouriteSongsState {}

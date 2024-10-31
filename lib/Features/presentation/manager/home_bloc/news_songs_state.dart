part of 'news_songs_cubit.dart';

abstract class NewsSongsState {}

final class NewsSongsLoading extends NewsSongsState {}
final class NewsSongsLoaded extends NewsSongsState {
  final List<SongEntity> songs;
  NewsSongsLoaded({required this.songs});

}

class NewsSongsError extends NewsSongsState {
  final String message;
  NewsSongsError(this.message);
}

part of 'play_list_cubit.dart';

abstract class PlayListState {}

final class PlayListLoading extends PlayListState {}
final class PlayListLoaded extends PlayListState {
  final List<SongEntity> songs;

  PlayListLoaded({required this.songs});
}
final class PlayListError extends PlayListState {
  final String message;

  PlayListError({required this.message});
}
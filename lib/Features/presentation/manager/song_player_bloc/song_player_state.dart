part of 'song_player_cubit.dart';

abstract class SongPlayerState {}

final class SongPlayerLoading extends SongPlayerState {}
final class SongPlayerLoaded extends SongPlayerState {}
final class SongPlayerFailure extends SongPlayerState {}

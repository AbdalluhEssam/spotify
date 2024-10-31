import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

part 'song_player_state.dart';


class SongPlayerCubit extends Cubit<SongPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    _initializeAudioPlayer();
  }

  void _initializeAudioPlayer() async {
    // Ensuring the audio player is set up correctly before using it

    audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        songDuration = duration;
        updateSongPlayer();
      }
    });

    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });
  }

  void updateSongPlayer() {
    emit(SongPlayerLoaded());
  }

  Future<void> loadSong(String url) async {
    try {
      await audioPlayer.setUrl(url);
      emit(SongPlayerLoaded());
    } catch (e) {
      emit(SongPlayerFailure());
    }
  }

  Future<void> playOrPauseSong() async {
    if (audioPlayer.playing) {
      await audioPlayer.stop();
    } else {
      await audioPlayer.play();
    }
    emit(SongPlayerLoaded());
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}

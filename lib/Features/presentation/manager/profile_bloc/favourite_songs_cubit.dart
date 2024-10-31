import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../service_locator.dart';
import '../../../domain/entities/songs.dart';
import '../../../domain/use_cases/get_user_favourite.dart';

part 'favourite_songs_state.dart';

class FavouriteSongsCubit extends Cubit<FavouriteSongsState> {
  FavouriteSongsCubit() : super(FavouriteSongsLoading());

  List<SongEntity> songs = [];
  Future<void> getUserFavouriteSongs() async {
    final errorOrNews = await sl<GetUserFavouriteSongsUseCase>().call();
    errorOrNews.fold(
      (failure) => emit(FavouriteSongsFailure()),
      (data) {
        songs = data;
        emit(FavouriteSongsLoaded(songs: songs));
      },
    );
  }

  Future<void> removeFavouriteSong(int index) async {
    songs.removeAt(index);
    emit(FavouriteSongsLoaded(songs: songs));

  }
}

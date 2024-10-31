import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../service_locator.dart';
import '../../../domain/entities/songs.dart';
import '../../../domain/use_cases/get_news_songs.dart';

part 'news_songs_state.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit() : super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    final  errorOrNews = await sl<GetNewsSongsUseCase>().call();
    errorOrNews.fold(
      (failure) => emit(NewsSongsError(failure)),
      (data) => emit(NewsSongsLoaded(songs: data)),
    );
  }
}

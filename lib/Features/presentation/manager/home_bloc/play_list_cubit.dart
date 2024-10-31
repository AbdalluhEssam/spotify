import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/Features/domain/use_cases/get_play_list.dart';
import '../../../../service_locator.dart';
import '../../../domain/entities/songs.dart';
part 'play_list_state.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    var songs = await sl<GetPlayListUseCase>().call();

    songs.fold(
        (l) => emit(PlayListError(message: l.toString())),
        (songs) => emit(PlayListLoaded(songs: songs)));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/Features/domain/use_cases/add_or_remove_favorite.dart';

import '../../../service_locator.dart';

part 'favorite_button_state.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  void favoriteButtonUpdated(String songId) async {
    var result = await sl<AddOrRemoveFavoriteUseCase>().call(params: songId);

    result.fold(
      (l) => null,
      (isFavorite) => emit(FavoriteButtonUpdated(isFavorite: isFavorite)),
    );
  }
}

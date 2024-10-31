import 'package:get_it/get_it.dart';
import 'package:spotify/Features/data/repositories/auth_repository_impl.dart';
import 'package:spotify/Features/data/sources/songs/songs_firebase_service.dart';
import 'package:spotify/Features/domain/repositories/auth_repo.dart';
import 'package:spotify/Features/domain/use_cases/add_or_remove_favorite.dart';
import 'package:spotify/Features/domain/use_cases/get_news_songs.dart';
import 'package:spotify/Features/domain/use_cases/get_play_list.dart';
import 'package:spotify/Features/domain/use_cases/get_user.dart';
import 'package:spotify/Features/domain/use_cases/get_user_favourite.dart';
import 'package:spotify/Features/domain/use_cases/is_favorite.dart';
import 'package:spotify/Features/domain/use_cases/signup.dart';
import 'Features/data/repositories/song_repository_impl.dart';
import 'Features/data/sources/auth/auth_firebase_service.dart';
import 'Features/domain/repositories/song.dart';
import 'Features/domain/use_cases/signin.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //Firebase Service
  sl.registerSingleton<FirebaseAuthService>(FirebaseAuthServiceImpl());
  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());

  //Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SongRepository>(SongRepositoryImpl());

  //UseCases
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());
  sl.registerSingleton<GetPlayListUseCase>(GetPlayListUseCase());
  sl.registerSingleton<AddOrRemoveFavoriteUseCase>(AddOrRemoveFavoriteUseCase());
  sl.registerSingleton<IsFavoriteUseCase>(IsFavoriteUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());
  sl.registerSingleton<GetUserFavouriteSongsUseCase>(GetUserFavouriteSongsUseCase());
}

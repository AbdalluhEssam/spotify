import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/Features/presentation/manager/profile_bloc/favourite_songs_cubit.dart';
import 'package:spotify/Features/presentation/manager/profile_bloc/profile_cubit.dart';
import 'package:spotify/Features/presentation/pages/song_player/song_player.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';

import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/favorite_button/favorite_button.dart';
import '../../../../core/constants/app_urls.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        backgroundColor: Color(0xff2c2B2B),
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _profileInfo(context),
            const SizedBox(
              height: 20,
            ),
            _favoriteSongs(context)
          ],
        ),
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileCubit()..getUserProfile(),
        child: Container(
            alignment: Alignment.center,
            height: MediaQuery.sizeOf(context).height / 3.5,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(30)),
              color:
                  context.isDarkMode ? const Color(0xff2c2B2B) : Colors.white,
            ),
            child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ProfileLoaded) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            NetworkImage(state.userEntity.imageUrl!),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        state.userEntity.email!,
                        style: TextStyle(
                            color: context.isDarkMode
                                ? AppColors.white
                                : AppColors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        state.userEntity.name!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: context.isDarkMode
                                ? AppColors.white
                                : AppColors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ]);
              } else {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
            })));
  }

  Widget _favoriteSongs(BuildContext context) {
    return BlocProvider(
        create: (context) => FavouriteSongsCubit()..getUserFavouriteSongs(),
        child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "FAVORITES SONGS",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color:
                        context.isDarkMode ? AppColors.white : AppColors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<FavouriteSongsCubit, FavouriteSongsState>(
                builder: (context, state) {
                  if (state is FavouriteSongsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FavouriteSongsLoaded) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SongPlayerPage(songEntity: state.songs[index]),
                              ));
                        },
                        child: Row(children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(
                                    '${AppURLs.coverFireStorageUrl}${state.songs[index].artist} - ${state.songs[index].title}.jpg?${AppURLs.mediaAlt}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.songs[index].title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: context.isDarkMode
                                        ? AppColors.white
                                        : AppColors.black),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                state.songs[index].artist,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: context.isDarkMode
                                        ? AppColors.white
                                        : AppColors.black),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(state.songs[index].duration
                                  .toString()
                                  .replaceAll('.', ':')),
                              const SizedBox(
                                width: 8,
                              ),
                              FavoriteButton(
                                key: UniqueKey(),
                                songEntity: state.songs[index],
                                onFavoriteChanged: () {
                                  context
                                      .read<FavouriteSongsCubit>()
                                      .removeFavouriteSong(index);
                                },
                              ),
                            ],
                          )
                        ]),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 12,
                      ),
                      itemCount: state.songs.length,
                    );
                  } else {
                    return const Text('Something went wrong');
                  }
                },
              )
            ])));
  }
}

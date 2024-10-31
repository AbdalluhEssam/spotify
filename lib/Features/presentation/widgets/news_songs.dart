import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/Features/presentation/manager/home_bloc/news_songs_cubit.dart';
import 'package:spotify/Features/presentation/pages/song_player/song_player.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/core/constants/app_urls.dart';

import '../../domain/entities/songs.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NewsSongsCubit()..getNewsSongs(),
        child: SizedBox(
            height: 200,
            child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
              builder: (context, state) {
                if (state is NewsSongsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NewsSongsLoaded) {
                  return _songsList(state.songs);
                } else {
                  return const Text('Something went wrong');
                }
              },
            )));
  }

  Widget _songsList(List<SongEntity> songs) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  SongPlayerPage(songEntity: songs[index],),
                ));
          },
          child: SizedBox(
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          '${AppURLs.coverFireStorageUrl}${songs[index].artist} - ${songs[index].title}.jpg?${AppURLs.mediaAlt}'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      clipBehavior: Clip.none,
                      height: 40,
                      width: 40,
                      transform: Matrix4.translationValues(10, 10, 0),
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? AppColors.darkGray
                            : const Color(0xffE6E6E6),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.play_arrow,
                        color: context.isDarkMode
                            ? AppColors.white
                            : AppColors.darkGray,
                      ),
                    ),
                  ),
                )),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  songs[index].title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  songs[index].artist,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        width: 12,
      ),
    );
  }
}

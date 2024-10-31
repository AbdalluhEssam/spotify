import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/Features/domain/entities/songs.dart';
import 'package:spotify/Features/presentation/manager/home_bloc/play_list_cubit.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/widgets/favorite_button/favorite_button.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../pages/song_player/song_player.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayListCubit()..getPlayList(),
      child: BlocBuilder<PlayListCubit, PlayListState>(
        builder: (context, state) {
          if (state is PlayListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PlayListLoaded) {
            return _playList(state.songs);
          } else {
            return const Text('Something went wrong');
          }
        },
      ),
    );
  }

  Widget _playList(List<SongEntity> playList) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'PlayList',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffc6c6c6)),
                ),
              ]),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
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
                      Icons.play_arrow_rounded,
                      color: context.isDarkMode
                          ? AppColors.white
                          : AppColors.darkGray,
                    ),
                  ),
                  onTap: () {

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  SongPlayerPage(songEntity: playList[index],),
                        ));
                  },
                  minLeadingWidth: 50,
                  title: Text(
                    playList[index].title,
                    style: TextStyle(
                        color: context.isDarkMode
                            ? AppColors.white
                            : AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  subtitle: Text(playList[index].artist),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(playList[index]
                          .duration
                          .toString()
                          .replaceAll('.', ':')),
                      const SizedBox(
                        width: 8,
                      ),
                      FavoriteButton(songEntity: playList[index])
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: playList.length)
        ],
      ),
    );
  }
}

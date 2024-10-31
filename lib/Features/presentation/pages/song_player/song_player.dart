import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/Features/domain/entities/songs.dart';
import 'package:spotify/Features/presentation/manager/song_player_bloc/song_player_cubit.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';

import '../../../../common/widgets/favorite_button/favorite_button.dart';
import '../../../../core/constants/app_urls.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;

  const SongPlayerPage({super.key, required this.songEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Text(
          'Now Playing',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        actions: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_rounded),
        ),
      ),
      body: BlocProvider(
        create: (context) => SongPlayerCubit()
          ..loadSong(
              '${AppURLs.songFireStorageUrl}${songEntity.artist} - ${songEntity.title}.mp3?${AppURLs.mediaAlt}'),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: NetworkImage(
                      '${AppURLs.coverFireStorageUrl}${songEntity.artist} - ${songEntity.title}.jpg?${AppURLs.mediaAlt}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      songEntity.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      songEntity.artist,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                FavoriteButton(songEntity: songEntity)

              ],
            ),
            const SizedBox(
              height: 20,
            ),
            _songPlayer(context),
            const SizedBox(
              height: 20,
            )
          ]),
        ),
      ),
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
        builder: (context, state) {
      if (state is SongPlayerLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is SongPlayerLoaded) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Slider(
              value: context
                  .read<SongPlayerCubit>()
                  .songPosition
                  .inSeconds
                  .toDouble(),
              max: context
                  .read<SongPlayerCubit>()
                  .songDuration
                  .inSeconds
                  .toDouble(),
              min: 0,
              activeColor: AppColors.white,
              onChanged: (value) {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatDuration(
                    context.read<SongPlayerCubit>().songPosition)),
                Text(formatDuration(
                    context.read<SongPlayerCubit>().songDuration)),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.primary,
              child: IconButton(
                  onPressed: () {
                    context.read<SongPlayerCubit>().playOrPauseSong();
                  },
                  icon: Icon(
                    context.read<SongPlayerCubit>().audioPlayer.playing
                        ? Icons.pause
                        : Icons.play_arrow_rounded,
                    color: AppColors.white,
                    size: 35,
                  )),
            ),
          ],
        );
      } else {
        return const Text('Something went wrong');
      }
    });
  }

  String formatDuration(Duration duration) {
    String twoDigitMinutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}

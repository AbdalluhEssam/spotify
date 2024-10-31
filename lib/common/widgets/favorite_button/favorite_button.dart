import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/Features/domain/entities/songs.dart';
import 'package:spotify/common/bloc/favorite_button/favorite_button_cubit.dart';

import '../../../core/configs/theme/app_colors.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity;
  final Function? onFavoriteChanged;

  const FavoriteButton({super.key, required this.songEntity, this.onFavoriteChanged});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FavoriteButtonCubit(),
        child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
            builder: (context, state) {
          if (state is FavoriteButtonInitial) {
            return IconButton(
              onPressed: () {
                context.read<FavoriteButtonCubit>().favoriteButtonUpdated(songEntity.songId);
                if (onFavoriteChanged != null) {
                  onFavoriteChanged!();
                }
              },
              icon: Icon(
                songEntity.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                color: AppColors.darkGray,
                size: 25,
              ),
            );
          } else if (state is FavoriteButtonUpdated) {
            return IconButton(
              onPressed: () {
                context.read<FavoriteButtonCubit>().favoriteButtonUpdated(songEntity.songId);
                if (onFavoriteChanged != null) {
                  onFavoriteChanged!();
                }
              },
              icon: Icon(
                state.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                color: AppColors.darkGray,
                size: 25,
              ),
            );
          } else {
            return const Icon(Icons.favorite_outline, color: Colors.white);
          }
        }));
  }
}

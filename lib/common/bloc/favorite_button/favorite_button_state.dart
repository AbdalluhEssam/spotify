part of 'favorite_button_cubit.dart';

abstract class FavoriteButtonState {}

final class FavoriteButtonInitial extends FavoriteButtonState {}
final class FavoriteButtonUpdated extends FavoriteButtonState {
  final bool isFavorite;
  FavoriteButtonUpdated({required this.isFavorite});
}

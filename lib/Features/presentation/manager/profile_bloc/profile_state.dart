part of 'profile_cubit.dart';


abstract class ProfileState {}

final class ProfileLoading extends ProfileState {}
final class ProfileLoaded extends ProfileState {
  final UserEntity userEntity;

  ProfileLoaded({required this.userEntity});
}
final class ProfileFailure extends ProfileState {}

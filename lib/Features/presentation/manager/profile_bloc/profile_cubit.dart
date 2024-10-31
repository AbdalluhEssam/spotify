import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/Features/domain/entities/user.dart';

import '../../../../service_locator.dart';
import '../../../domain/use_cases/get_user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading());

  Future<void> getUserProfile() async {
    var user = await sl<GetUserUseCase>().call();

    user.fold((l) => emit(ProfileFailure()),
        (userEntity) => emit(ProfileLoaded(userEntity: userEntity)));
  }

}

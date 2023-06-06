import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/profile.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading());

  void getProfile() {
    //todo call api
    // emit(ProfileLoaded(Profile()))
  }
}

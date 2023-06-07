import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/profile.dart';
import '../../../services/ride_service.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading());

  final _rideService = RideService();

  void getProfile() async {
    try {
      // userId =
      final profile = await _rideService.getProfile(userId);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(const ProfileError());
    }
  }
}
/*
final profile = Profile(
  id: 'id',
  name: 'name',
  surname: 'surname',
  age: 23,
  faculty: 'faculty',
  university: 'university',
  profilePictureUrl: 'profilePictureUrl',
  bio: 'bio',
  totalRidesGiven: 2,
  joinedIn: 'joinedIn',
  carDetails: CarDetails(
    carModel: 'carModel',
    carColor: 'carColor',
    carPlate: 'carPlate',
    totSeats: 5,
    carColorHex: Color(0xFF000000),
    licenseSince: 'May 2019',
  ),
  city: 'city',
  district: 'district',
  instagramName: 'instagramName',
  instagramUrl: 'instagramUrl',
);*/

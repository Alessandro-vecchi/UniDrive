import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uni_drive/models/booking.dart';

import '../../../models/profile.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading());

  void getProfile() {
    //todo call api
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
        userId: 'userId',
        carModel: 'carModel',
        carColor: 'carColor',
        carPlate: 'carPlate',
        totSeats: 'totSeats',
      ),
      city: 'city',
      district: 'district',
      instagramName: 'instagramName',
      instagramUrl: 'instagramUrl',
    );
    emit(ProfileLoaded(profile));
  }
}

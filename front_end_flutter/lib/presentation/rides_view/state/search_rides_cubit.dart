import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../models/ride.dart';
import '../../../models/search_model.dart';

part 'search_rides_state.dart';

class SearchRidesCubit extends Cubit<SearchRidesState> {
  SearchRidesCubit()
      : super(SearchRidesLoading(FormGroup({
          'destination': FormControl<String>(validators: [Validators.required]),
          'origin': FormControl<String>(validators: [Validators.required]),
          'date': FormControl<DateTime>(validators: [Validators.required]),
          'time': FormControl<TimeOfDay>(validators: [Validators.required]),
        })));

  void initForm(SearchModel searchModel) {
    state.form.patchValue({
      'destination': searchModel.destination,
      'origin': searchModel.origin,
      'date': searchModel.date,
      'time': searchModel.time,
    });
  }

  void searchRides() {
    //todo call Service
    log('searchRides');
    emit(
      SearchRidesLoaded(
        state.form,
        rides: const [
          Ride(
              id: 'id1',
              origin: 'origin1',
              destination: 'destination1',
              departDatetime: 'departDatetime1',
              driverProfile: ShortProfile(
                profilePictureUrl: 'profilePictureUrl1',
                name: 'name1',
                surname: 'surname1',
                rating: 4.5,
              ),
              meetingPoint: MeetingPoint(
                latitude: 1.0,
                longitude: 1.0,
                distance: 1,
                meetingTime: 1,
              ),
              availableSeats: 3),
          Ride(
              id: 'id2',
              origin: 'origin2',
              destination: 'destination2',
              departDatetime: 'departDatetime2',
              driverProfile: ShortProfile(
                profilePictureUrl: 'profilePictureUrl2',
                name: 'name2',
                surname: 'surname2',
                rating: 4.2,
              ),
              meetingPoint: MeetingPoint(
                latitude: 1.0,
                longitude: 1.0,
                distance: 1,
                meetingTime: 1,
              ),
              availableSeats: 2),
          Ride(
              id: 'id3',
              origin: 'origin3',
              destination: 'destination3',
              departDatetime: 'departDatetime3',
              driverProfile: ShortProfile(
                profilePictureUrl: 'profilePictureUrl3',
                name: 'name3',
                surname: 'surname3',
                rating: 3.8,
              ),
              meetingPoint: MeetingPoint(
                latitude: 1.0,
                longitude: 1.0,
                distance: 1,
                meetingTime: 1,
              ),
              availableSeats: 1),
        ],
      ),
    );
  }
}

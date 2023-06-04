import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../models/ride.dart';
import '../../../models/search_model.dart';
import '../../../services/ride_service.dart';

part 'search_rides_state.dart';

class SearchRidesCubit extends Cubit<SearchRidesState> {
  final _rideService = RideService();

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

  void searchRides() async {
    try {
      // todo call service
      final formValue = state.form.value;
      final searchModel = SearchModel.fromForm(formValue);

      final result = await _rideService.getRides(searchModel: searchModel);
      emit(SearchRidesLoaded(
        state.form,
        rides: result,
      ));
    } catch (e) {
      emit(SearchRidesError(state.form));
    }
  }
}

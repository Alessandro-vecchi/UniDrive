import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/booking.dart';
import '../../../services/ride_service.dart';

part 'booking_view_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingLoading());
  final _rideService = RideService();

  void getProfile(String rideId) async {
    try {
      final booking = await _rideService.bookRide(rideId);
      emit(BookingLoaded(booking));
    } catch (e) {
      emit(const BookingError());
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/booking.dart';
import '../../../services/ride_service.dart';

part 'booking_view_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(const BookingIdle());
  final _rideService = RideService();

  void bookRide(String rideId) async {
    try {
      emit(const BookingOperationLoading());
      final booking = await _rideService.bookRide(rideId);
      emit(Booked(booking));
    } catch (e) {
      emit(const BookingError());
    }
  }

  void cancelBooking(String rideId, String bookingId) async {
    try {
      await _rideService.cancelBooking(rideId, bookingId);
      emit(const BookingIdle());
    } catch (e) {
      emit(const BookingError());
    }
  }
}

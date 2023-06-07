part of 'booking_view_cubit.dart';

sealed class BookingState extends Equatable {
  const BookingState();
}

class BookingLoading extends BookingState {
  @override
  List<Object> get props => [];
}

class BookingLoaded extends BookingState {
  final Booking booking;

  const BookingLoaded(this.booking);

  @override
  List<Object> get props => [booking];
}

class BookingError extends BookingState {
  const BookingError();

  @override
  List<Object> get props => [];
}

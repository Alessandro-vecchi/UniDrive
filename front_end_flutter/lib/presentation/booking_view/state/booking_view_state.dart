part of 'booking_view_cubit.dart';

sealed class BookingState extends Equatable {
  const BookingState();
}

class BookingIdle extends BookingState {
  const BookingIdle();

  @override
  List<Object> get props => [];
}

class BookingOperationLoading extends BookingState {
  const BookingOperationLoading();
  @override
  List<Object> get props => [];
}

class Booked extends BookingState {
  final Booking booking;

  const Booked(this.booking);

  @override
  List<Object> get props => [booking];
}

class BookingError extends BookingState {
  const BookingError();

  @override
  List<Object> get props => [];
}

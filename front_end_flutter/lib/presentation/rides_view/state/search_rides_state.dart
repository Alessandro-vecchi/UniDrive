part of 'search_rides_cubit.dart';

@immutable
sealed class SearchRidesState extends Equatable {
  final FormGroup form;

  const SearchRidesState(this.form);
}

class SearchRidesLoading extends SearchRidesState {
  const SearchRidesLoading(super.form);

  @override
  List<Object?> get props => [form];
}

class SearchRidesLoaded extends SearchRidesState {
  final List<Ride> rides;

  const SearchRidesLoaded(super.form, {required this.rides});

  @override
  List<Object?> get props => [form, rides];
}

class SearchRidesError extends SearchRidesState {
  const SearchRidesError(super.form);

  @override
  List<Object?> get props => [form];
}

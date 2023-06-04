part of 'map_view_cubit.dart';

sealed class MapViewState extends Equatable {
  const MapViewState();
}

class MapViewInitial extends MapViewState {
  @override
  List<Object> get props => [];
}

class MapViewSearching extends MapViewState {
  @override
  List<Object> get props => [];
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'map_view_state.dart';

class MapViewCubit extends Cubit<MapViewState> {
  MapViewCubit() : super(MapViewInitial());

  void search() {
    emit(MapViewSearching());
  }

  void cancelSearch() {
    emit(MapViewInitial());
  }
}

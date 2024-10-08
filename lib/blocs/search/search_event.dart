part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnActivateManualMarkerEvent extends SearchEvent {}

class OnDeactivateManualMarkerEvent extends SearchEvent {}

class OnNewPlacesFoundEvent extends SearchEvent {
  final List<Feature> places;
  const OnNewPlacesFoundEvent({required this.places});
}

class OnAddToHistoryEvent extends SearchEvent {
  final Feature place;
  const OnAddToHistoryEvent({required this.place});
}

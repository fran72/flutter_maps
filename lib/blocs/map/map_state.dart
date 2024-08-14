part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool? isMapInitialized;
  final bool? followUser;
  final bool? showMyRoute;
  final Map<String, Polyline>? polylines;

  const MapState({
    this.isMapInitialized = false,
    this.followUser = false,
    this.showMyRoute = false,
    this.polylines = const {},
  });

  MapState copyWith({
    bool? isMapInitialized,
    bool? followUser,
    bool? showMyRoute = false,
    Map<String, Polyline>? polylines,
  }) =>
      MapState(
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        followUser: followUser ?? this.followUser,
        showMyRoute: showMyRoute ?? this.showMyRoute,
        polylines: polylines ?? this.polylines,
      );

  @override
  List<Object> get props => [
        {isMapInitialized, followUser, showMyRoute, polylines}
      ];
}

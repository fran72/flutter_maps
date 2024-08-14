part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool? followingUser;
  final LatLng? lastKnownPosition;
  final List<LatLng>? myLocationHistory;

  const LocationState(
      {this.followingUser, this.lastKnownPosition, this.myLocationHistory});
  // si falla es por esto

  LocationState copyWith({
    bool? followingUser,
    LatLng? lastKnownPosition,
    List<LatLng>? myLocationHistory,
  }) =>
      LocationState(
        followingUser: followingUser ?? this.followingUser,
        lastKnownPosition: lastKnownPosition ?? this.lastKnownPosition,
        myLocationHistory: myLocationHistory ?? this.myLocationHistory,
      );

  @override
  List<Object> get props => [
        {followingUser, lastKnownPosition, myLocationHistory}
      ];
}

// class LocationInitial extends LocationState {
//   const LocationInitial() : super();
// }

part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  final bool followingUser;

  const LocationState(this.followingUser);

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {
  const LocationInitial(super.followingUser);
}

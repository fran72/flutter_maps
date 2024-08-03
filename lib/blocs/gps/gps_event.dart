part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}

class GpsAndPermissionsEvent extends GpsEvent {
  final bool isGpsEnable;
  final bool isGpsPermissionGranted;

  const GpsAndPermissionsEvent(
    this.isGpsEnable,
    this.isGpsPermissionGranted,
  );
}

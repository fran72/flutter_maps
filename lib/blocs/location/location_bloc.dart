import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  late StreamSubscription positionStream;

  LocationBloc() : super(const LocationInitial(false)) {
    on<LocationEvent>((event, emit) {});
  }

  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    debugPrint(position.toString());
    // return await Geolocator.getCurrentPosition();
  }

  void startFollowingUser() {
    positionStream = Geolocator.getPositionStream().listen((event) {
      final position = event;
      debugPrint(position.toString());
    });
  }

  void stopFollowingUser() {
    positionStream.cancel();
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}

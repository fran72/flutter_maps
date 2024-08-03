import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  late StreamSubscription gpsServiceSubscription;

  GpsBloc()
      : super(
            const GpsState(isGpsEnable: false, isGpsPermissionGranted: false)) {
    on<GpsEvent>((event, emit) {});
    on<GpsAndPermissionsEvent>((event, emit) => emit(state.copyWith(
          event.isGpsEnable,
          event.isGpsPermissionGranted,
        )));

    _init();
  }

  Future<void> _init() async {
    // final isEnable = await _checkGpsStatus();
    // final isGranted = await _isPermissionGranted();

    final gpsInitStatus = await Future.wait({
      _checkGpsStatus(),
      _isPermissionGranted(),
    });

    add(GpsAndPermissionsEvent(gpsInitStatus[0], gpsInitStatus[1]));
  }

  Future<bool> _isPermissionGranted() async {
    final isGranted = Permission.location.isGranted;
    return isGranted;
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();

    gpsServiceSubscription =
        Geolocator.getServiceStatusStream().listen((event) {
      final isEnable = event.index == 1 ? true : false;
      debugPrint('_checkGpsStatus......$isEnable');
      add(GpsAndPermissionsEvent(isEnable, state.isGpsPermissionGranted));
    });

    return isEnable;
  }

  Future<void> askGpsStatus() async {
    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.denied:
        add(GpsAndPermissionsEvent(state.isGpsEnable, true));

      case PermissionStatus.granted:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.provisional:
        add(GpsAndPermissionsEvent(state.isGpsEnable, false));
        openAppSettings();
    }
    // status.isGranted ?

    // return isEnable;
  }

  @override
  Future<void> close() {
    gpsServiceSubscription.cancel();
    return super.close();
  }
}

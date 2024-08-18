import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/blocs/blocs.dart';
import 'package:mapas_app/helpers/widgets_to_marker.dart';
import 'package:mapas_app/models/models.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  LatLng? mapCenter;

  GoogleMapController? mapController;

  StreamSubscription<LocationState>? locationStateSubscription;

  MapBloc(this.locationBloc) : super(const MapState()) {
    on<OnMapInitializedEvent>(_onInitMap);
    on<OnStartFollowingUser>(_onStartFollowingUser);
    on<OnStopFollowingUser>(
        (event, emit) => emit(state.copyWith(followUser: false)));
    on<UpdateUserPolylinesEvent>(_onPolylineNewPoint);
    on<OnToggleUserRoute>((event, emit) =>
        emit(state.copyWith(showMyRoute: !state.showMyRoute!)));
    on<DisplayPolylinesEvent>((event, emit) => emit(
        state.copyWith(polylines: event.polylines, markers: event.markers)));

    locationStateSubscription = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnownPosition != null) {
        add(UpdateUserPolylinesEvent(locationState.myLocationHistory!));
      }

      if (state.followUser != null) return;
      if (locationState.lastKnownPosition == null) return;
      moveCamera(locationState.lastKnownPosition!);
    });

    // on<OnMapInitializedEvent>((event, emit) {
    //   emit(state.copyWith(isMapInitialized: true));
    // });
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    mapController = event.controller;
    mapController!.getStyleError().then((value) {
      final err = value;
      debugPrint(
          'errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr......................... ${err.toString()}');
    });

    emit(state.copyWith(isMapInitialized: true));
  }

  void _onStartFollowingUser(
      OnStartFollowingUser event, Emitter<MapState> emit) {
    emit(state.copyWith(followUser: true));
    if (locationBloc.state.lastKnownPosition == null) return;
    moveCamera(locationBloc.state.lastKnownPosition!);
  }

  void _onPolylineNewPoint(
      UpdateUserPolylinesEvent event, Emitter<MapState> emit) {
    final myRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.userLocations,
    );
    final currentPolyline = Map<String, Polyline>.from(state.polylines!);
    currentPolyline['myRoute'] = myRoute;
    emit(state.copyWith(polylines: currentPolyline));
  }

  Future drawRoutePolyline(RouteDestination destination) async {
    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: destination.points,
    );
    final currentPolyline = Map<String, Polyline>.from(state.polylines!);
    currentPolyline['route'] = myRoute;

    double kms = destination.distance / 1000;
    kms = (kms * 100).floorToDouble();
    kms /= 100;

    double tripDuration = (destination.distance / 60).floorToDouble();
    // double tripDuration = (destination.distance / 60).floorToDouble();

    // final startMarkerIcon = await getAssetImagemarker();
    // final endMarkerIcon = await getUrlImagemarker();

    final startMarkerIcon =
        await getStartCustomMarker(tripDuration.toInt(), 'Mi ubicacion');
    final endMarkerIcon = await getEndCustomMarker(
        kms.toInt(), destination.endPlace.properties.name);

    final startMarker = Marker(
      anchor: const Offset(0.1, 1),
      markerId: const MarkerId('start'),
      position: destination.points.first,
      icon: startMarkerIcon,
      // infoWindow: InfoWindow(
      //   title: 'start',
      //   snippet: 'kms: $kms, duration: $tripDuration',
      // ),
    );

    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: destination.points.last,
      icon: endMarkerIcon,
      anchor: const Offset(0, 0),
      // infoWindow: InfoWindow(
      //   title: 'end',
      //   snippet: destination.endPlace.properties.name,
      // ),
    );

    final currentMarkers = Map<String, Marker>.from(state.markers!);
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;

    add(DisplayPolylinesEvent(currentPolyline, currentMarkers));

    await Future.delayed(const Duration(milliseconds: 300));
    mapController!.showMarkerInfoWindow(const MarkerId('end'));
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    mapController!.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}

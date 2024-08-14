import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/blocs/blocs.dart';
import 'package:mapas_app/themes/themes.dart';

class MapView extends StatelessWidget {
  final LatLng initialLocation;
  final Set<Polyline> polylines;

  const MapView(
      {super.key, required this.initialLocation, required this.polylines});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    CameraPosition initialCameraPosition = CameraPosition(
      target: initialLocation,
      zoom: 14,
    );

    final size = MediaQuery.of(context).size;

    debugPrint('jsonEncode(uberMapTheme)..........');
    debugPrint(jsonEncode(dessertTheme));

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(
        onPointerMove: (event) => mapBloc.add(OnStopFollowingUser()),
        child: GoogleMap(
          polylines: polylines,
          style: jsonEncode(dessertTheme),
          // mapType: MapType.hybrid,
          initialCameraPosition: initialCameraPosition,
          onMapCreated: (controller) =>
              mapBloc.add(OnMapInitializedEvent(controller)),
        ),
      ),
    );
  }
}

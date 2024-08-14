import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:mapas_app/blocs/gps/gps_bloc.dart';
import 'package:mapas_app/blocs/location/location_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/blocs/map/map_bloc.dart';
import 'package:mapas_app/views/map_view.dart';
import 'package:mapas_app/widgets/btn_follow_user.dart';
import 'package:mapas_app/widgets/btn_location.dart';
import 'package:mapas_app/widgets/btn_toggle_user_route.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.getCurrentPosition().toString();
    locationBloc.startFollowingUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          // final gpsBloc = BlocProvider.of<GpsBloc>(context);

          if (locationState.lastKnownPosition == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Text('No hay position'),
                  // Text('last position.....${state.lastKnownPosition}'),
                  // Text('is-gps.....${gpsBloc.state.isGpsEnable}'),
                  // Text(
                  //     'is-permitted...${gpsBloc.state.isGpsPermissionGranted}'),
                  MaterialButton(
                    onPressed: () {
                      debugPrint('fffffff');
                    },
                    color: Colors.yellow,
                    shape: const StadiumBorder(),
                    child: const Text('Habilitar GPS'),
                  ),
                ],
              ),
            );
          } else {
            return BlocBuilder<MapBloc, MapState>(builder: (context, mapState) {
              Map<String, Polyline> polylines = Map.from(mapState.polylines!);
              if (!mapState.showMyRoute!) {
                polylines.removeWhere((key, value) => key == 'myRoute');
              }
              return Stack(
                children: [
                  MapView(
                    initialLocation: locationState.lastKnownPosition!,
                    polylines: polylines.values.toSet(),
                  ),
                  // const Center(
                  //   child: Text(
                  //     'data',
                  //     style: TextStyle(color: Colors.white, fontSize: 24.0),
                  //   ),
                  // ),
                ],
              );
            });

            // return Center(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       const Text('<Si> hay position'),
            //       Text(
            //           '${state.lastKnownPosition!.latitude} , ${state.lastKnownPosition!.longitude}'),
            //     ],
            //   ),
            // );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnToggleUserRoute(),
          BtnFollowUser(),
          BtnLocation(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }
}

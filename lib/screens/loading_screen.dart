import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/blocs/blocs.dart';
import 'package:mapas_app/screens/gps_access_screen.dart';
import 'package:mapas_app/screens/map_screen.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          debugPrint('is all granted...  ${state.isAllGranted}');
          return state.isAllGranted
              ? const MapScreen()
              : const GpsAccessScreen();
        },
      ),
    );
  }
}

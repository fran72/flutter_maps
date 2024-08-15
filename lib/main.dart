import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/blocs/blocs.dart';
import 'package:mapas_app/screens/loading_screen.dart';
import 'package:mapas_app/services/traffic_service.dart';

void main() => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GpsBloc()),
          BlocProvider(create: (context) => LocationBloc()),
          BlocProvider(
              create: (context) =>
                  MapBloc(BlocProvider.of<LocationBloc>(context))),
          BlocProvider(
              create: (context) => SearchBloc(trafficervice: TrafficService())),
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maps App',
      home: LoadingScreen(),
    );
  }
}

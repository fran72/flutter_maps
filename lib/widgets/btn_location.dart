import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/blocs/blocs.dart';

class BtnLocation extends StatelessWidget {
  const BtnLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
            color: Colors.black,
            onPressed: () {
              final userLocation = locationBloc.state.lastKnownPosition;
              if (userLocation == null) {
                const snack =
                    SnackBar(content: Text('Aun no se tu posicion...'));
                ScaffoldMessenger.of(context).showSnackBar(snack);
                return;
              }
              mapBloc.moveCamera(userLocation);
            },
            icon: const Icon(Icons.my_location_outlined)),
      ),
    );
  }
}

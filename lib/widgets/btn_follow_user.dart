import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/blocs/blocs.dart';

class BtnFollowUser extends StatelessWidget {
  const BtnFollowUser({super.key});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) => IconButton(
            color: Colors.black,
            onPressed: () {
              mapBloc.add(OnStartFollowingUser());
            },
            icon: Icon(state.followUser!
                ? Icons.directions_run_outlined
                : Icons.directions_walk),
          ),
        ),
      ),
    );
  }
}

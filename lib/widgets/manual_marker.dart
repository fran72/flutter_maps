import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/blocs/blocs.dart';
import 'package:mapas_app/helpers/helpers.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker!
            ? const _ManualMarkerBody()
            : Container();
      },
    );
  }
}

class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          const Positioned(
            top: 70,
            left: 70,
            child: _BtnBack(),
          ),
          Center(
            child: Transform.translate(
              offset: const Offset(0, -2),
              child: BounceInDown(
                child: const Icon(Icons.location_history),
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            left: 20,
            child: MaterialButton(
              onPressed: () async {
                final start = locationBloc.state.lastKnownPosition;
                if (start == null) return;
                final end = mapBloc.mapCenter;
                if (end == null) return;

                showLoadingMessage(context);

                final destination =
                    await searchBloc.getCoorsStartToEnd(start, end);
                await mapBloc.drawRoutePolyline(destination);

                searchBloc.add(OnDeactivateManualMarkerEvent());

                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              color: Colors.black,
              shape: const StadiumBorder(),
              child: const Text(
                'Confirmar el destino',
                style: TextStyle(color: Colors.amber),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack();

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    return FadeInLeft(
      child: CircleAvatar(
        maxRadius: 22,
        backgroundColor: Colors.white70,
        child: IconButton(
            onPressed: () {
              searchBloc.add(OnDeactivateManualMarkerEvent());
            },
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.red)),
      ),
    );
  }
}

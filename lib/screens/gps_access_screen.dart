import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/blocs/gps/gps_bloc.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            debugPrint('pasas por aquiiiii..... $state');
            return !state.isGpsEnable
                ? _EnableGpsMessage(state.isGpsEnable)
                : const _AccessButton();
          },
        ),
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Debes habilitar el GPS'),
        MaterialButton(
          color: Colors.amber,
          onPressed: () {
            final gpsBloc = BlocProvider.of<GpsBloc>(context);
            gpsBloc.askGpsStatus();
          },
          shape: const StadiumBorder(),
          child: const Text('Habilitar GPS'),
        ),
      ],
    );
  }
}

// ignore: unused_element
class _EnableGpsMessage extends StatelessWidget {
  final bool isGpsEnable;
  const _EnableGpsMessage(this.isGpsEnable);

  @override
  Widget build(BuildContext context) {
    return Text('Debes habilitar el GPS...$isGpsEnable');
  }
}
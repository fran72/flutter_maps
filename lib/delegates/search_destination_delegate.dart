import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/blocs/blocs.dart';
import 'package:mapas_app/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate {
  SearchDestinationDelegate() : super(searchFieldLabel: 'Buscar...');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        final result = SearchResult(cancel: true);
        close(context, result);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final proximity =
        BlocProvider.of<LocationBloc>(context).state.lastKnownPosition;
    searchBloc.getPlacesByQuery(proximity!, query);

    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      return (state.places.isNotEmpty)
          ? ListView.separated(
              itemCount: 5,
              itemBuilder: (context, index) {
                // final place = state.places[index];   ....peta
                debugPrint('ffffffffff $state');

                return ListTile(
                  leading: const Icon(Icons.place_outlined),
                  title: Text(
                      'idx.: ${state.places[index].geometry.coordinates.last}'),
                  subtitle: Text('type: ${state.places[index].geometry.type}'),
                  onTap: () {
                    final result = SearchResult(
                      cancel: false,
                      manual: false,
                      position: LatLng(
                          state.places[index].properties.coordinates.latitude,
                          state.places[index].properties.coordinates.longitude),
                      name: state.places[index].properties.name,
                      description:
                          state.places[index].properties.placeFormatted,
                    );

                    // llamas a addPointToHistory
                    searchBloc
                        .add(OnAddToHistoryEvent(place: state.places[index]));
                    close(context, result);
                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            )
          : const Text('no hay data');
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final history = BlocProvider.of<SearchBloc>(context).state.history;
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.location_on_outlined),
          title: const Text('Colocar la ubicacion manualmente'),
          onTap: () {
            final result = SearchResult(cancel: false, manual: true);
            close(context, result);
          },
        ),

        // lista de history...........................................
        ...history.map(
          (e) => ListTile(
            leading: const Icon(Icons.history),
            title: Text(e.properties.name),
            subtitle: Text(e.properties.namePreferred),
          ),
        ),
      ],
    );
  }
}

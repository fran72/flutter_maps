import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:mapas_app/models/places_response.dart';
import 'package:mapas_app/models/traffic_response.dart';
import 'package:mapas_app/services/services.dart';
import 'package:flutter/material.dart';

class TrafficService {
  final Dio _dioTraffic;
  final Dio _dioPlaces;
  final String _baseTrafficUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  final String _basePlacesUrl =
      'https://api.mapbox.com/search/geocode/v6/forward';

  TrafficService()
      : _dioTraffic = Dio()..interceptors.add(TrafficInterceptor()),
        _dioPlaces = Dio()..interceptors.add(PlacesInterceptor());

  Future<TrafficResponse> getCoorsStartToEnd(LatLng start, LatLng end) async {
    final coorsString =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '$_baseTrafficUrl/driving/$coorsString';

    final resp = await _dioTraffic.get(url);

    final data = TrafficResponse.fromJson(resp.data);

    return data;
  }

  Future<List<Feature>> getResultsByQuery(
      LatLng proximity, String query) async {
    debugPrint('query..................');
    debugPrint(query);

    if (query.isEmpty) return [];

    final url = '$_basePlacesUrl?q=$query';

    final resp = await _dioPlaces.get(url);
    // TO-DO Si la query NO arroja resultados...peta el modelo

    // final resp = await _dioPlaces.get('https://api.mapbox.com/search/geocode/v6/forward?q=aeropuerto');
    // final resp = await _dioPlaces.get(_basePlacesUrl, queryParameters: {'q': query});

    final placesResponse = PlacesResponse.fromJson(resp.data);

    return placesResponse.features;
  }

  Future<Feature> getInformationByCoors(LatLng coors) async {
    final url = '$_basePlacesUrl/${coors.longitude},${coors.latitude}';
    final resp = await _dioPlaces.get(url, queryParameters: {'limit': 1});
    final placesResponse = PlacesResponse.fromJson(resp.data);
    return placesResponse.features[0];
  }
}

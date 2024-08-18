// To parse this JSON data, do
//
//     final placesResponse = placesResponseFromJson(jsonString);

import 'dart:convert';

PlacesResponse placesResponseFromJson(String str) =>
    PlacesResponse.fromJson(json.decode(str));

String placesResponseToJson(PlacesResponse data) => json.encode(data.toJson());

class PlacesResponse {
  String type;
  List<Feature> features;
  String attribution;

  PlacesResponse({
    required this.type,
    required this.features,
    required this.attribution,
  });

  factory PlacesResponse.fromJson(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
      };
}

class Feature {
  String type;
  String id;
  Geometry geometry;
  Properties properties;

  Feature({
    required this.type,
    required this.id,
    required this.geometry,
    required this.properties,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        type: json["type"],
        id: json["id"],
        geometry: Geometry.fromJson(json["geometry"]),
        properties: Properties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "geometry": geometry.toJson(),
        "properties": properties.toJson(),
      };
}

class Geometry {
  String type;
  List<double> coordinates;

  Geometry({
    required this.type,
    required this.coordinates,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Properties {
  String mapboxId;
  String featureType;
  String fullAddress;
  String name;
  String namePreferred;
  Coordinates coordinates;
  String placeFormatted;
  List<double> bbox;
  Context context;

  Properties({
    required this.mapboxId,
    required this.featureType,
    required this.fullAddress,
    required this.name,
    required this.namePreferred,
    required this.coordinates,
    required this.placeFormatted,
    required this.bbox,
    required this.context,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        mapboxId: json["mapbox_id"],
        featureType: json["feature_type"],
        fullAddress: json["full_address"],
        name: json["name"],
        namePreferred: json["name_preferred"],
        coordinates: Coordinates.fromJson(json["coordinates"]),
        placeFormatted: json["place_formatted"],
        bbox: List<double>.from(json["bbox"].map((x) => x?.toDouble())),
        context: Context.fromJson(json["context"]),
      );

  Map<String, dynamic> toJson() => {
        "mapbox_id": mapboxId,
        "feature_type": featureType,
        "full_address": fullAddress,
        "name": name,
        "name_preferred": namePreferred,
        "coordinates": coordinates.toJson(),
        "place_formatted": placeFormatted,
        "bbox": List<dynamic>.from(bbox.map((x) => x)),
        "context": context.toJson(),
      };
}

class Context {
  Postcode? postcode;
  Locality locality;
  Locality place;
  Region region;
  Country country;
  Locality? neighborhood;
  Locality? district;

  Context({
    this.postcode,
    required this.locality,
    required this.place,
    required this.region,
    required this.country,
    this.neighborhood,
    this.district,
  });

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        postcode: json["postcode"] == null
            ? null
            : Postcode.fromJson(json["postcode"]),
        locality: Locality.fromJson(json["locality"]),
        place: Locality.fromJson(json["place"]),
        region: Region.fromJson(json["region"]),
        country: Country.fromJson(json["country"]),
        neighborhood: json["neighborhood"] == null
            ? null
            : Locality.fromJson(json["neighborhood"]),
        district: json["district"] == null
            ? null
            : Locality.fromJson(json["district"]),
      );

  Map<String, dynamic> toJson() => {
        "postcode": postcode?.toJson(),
        "locality": locality.toJson(),
        "place": place.toJson(),
        "region": region.toJson(),
        "country": country.toJson(),
        "neighborhood": neighborhood?.toJson(),
        "district": district?.toJson(),
      };
}

class Country {
  String mapboxId;
  String name;
  String wikidataId;
  String countryCode;
  String countryCodeAlpha3;

  Country({
    required this.mapboxId,
    required this.name,
    required this.wikidataId,
    required this.countryCode,
    required this.countryCodeAlpha3,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        mapboxId: json["mapbox_id"],
        name: json["name"],
        wikidataId: json["wikidata_id"],
        countryCode: json["country_code"],
        countryCodeAlpha3: json["country_code_alpha_3"],
      );

  Map<String, dynamic> toJson() => {
        "mapbox_id": mapboxId,
        "name": name,
        "wikidata_id": wikidataId,
        "country_code": countryCode,
        "country_code_alpha_3": countryCodeAlpha3,
      };
}

class Locality {
  String mapboxId;
  String name;
  String? wikidataId;

  Locality({
    required this.mapboxId,
    required this.name,
    this.wikidataId,
  });

  factory Locality.fromJson(Map<String, dynamic> json) => Locality(
        mapboxId: json["mapbox_id"],
        name: json["name"],
        wikidataId: json["wikidata_id"],
      );

  Map<String, dynamic> toJson() => {
        "mapbox_id": mapboxId,
        "name": name,
        "wikidata_id": wikidataId,
      };
}

class Postcode {
  String mapboxId;
  String name;

  Postcode({
    required this.mapboxId,
    required this.name,
  });

  factory Postcode.fromJson(Map<String, dynamic> json) => Postcode(
        mapboxId: json["mapbox_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "mapbox_id": mapboxId,
        "name": name,
      };
}

class Region {
  String mapboxId;
  String name;
  String wikidataId;
  String regionCode;
  String regionCodeFull;
  Locality? alternate;

  Region({
    required this.mapboxId,
    required this.name,
    required this.wikidataId,
    required this.regionCode,
    required this.regionCodeFull,
    this.alternate,
  });

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        mapboxId: json["mapbox_id"],
        name: json["name"],
        wikidataId: json["wikidata_id"],
        regionCode: json["region_code"],
        regionCodeFull: json["region_code_full"],
        alternate: json["alternate"] == null
            ? null
            : Locality.fromJson(json["alternate"]),
      );

  Map<String, dynamic> toJson() => {
        "mapbox_id": mapboxId,
        "name": name,
        "wikidata_id": wikidataId,
        "region_code": regionCode,
        "region_code_full": regionCodeFull,
        "alternate": alternate?.toJson(),
      };
}

class Coordinates {
  double longitude;
  double latitude;

  Coordinates({
    required this.longitude,
    required this.latitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
      };
}

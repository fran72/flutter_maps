import 'package:dio/dio.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'
    show BitmapDescriptor;

Future<BitmapDescriptor> getAssetImagemarker() async {
  return BitmapDescriptor.asset(
    const ImageConfiguration(devicePixelRatio: 2.5),
    'assets/custom-pin.png',
  );
}

Future<BitmapDescriptor> getUrlImagemarker() async {
  final resp = await Dio().get(
      'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png',
      options: Options(responseType: ResponseType.bytes));

  // resize url image
  final imageCodec = await ui.instantiateImageCodec(resp.data,
      targetHeight: 120, targetWidth: 120);
  final frame = await imageCodec.getNextFrame();
  final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);

  if (data == null) {
    return await getAssetImagemarker();
  }

  return BitmapDescriptor.bytes(data.buffer.asUint8List());
}

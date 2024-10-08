import 'package:dio/dio.dart';

class TrafficInterceptor extends Interceptor {
  final accessToken =
      'pk.eyJ1IjoiZnJhbjcyIiwiYSI6ImNsenRzNm54bTJkZG8ycnFyaDhycjZqNnIifQ.ycQy8Do0kldYk8cV62pAqQ';

  @override
  // ignore: unnecessary_overrides
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'geometries': 'polyline6',
      'access_token': accessToken,
    });
    super.onRequest(options, handler);
  }
}

import 'dart:ffi';

class GeoPoint{
  final double latitude = 0.0;
  final double longitude = 0.0;
}

class GeoLocation{
  GeoPoint geoPoint = GeoPoint();
  Float? accuracy;
  bool isAutomatic = false;
}
import 'geo_location.dart';

class InterestPoint{
  String id = "";
  String name = "";
  GeoLocation geoLocation = GeoLocation();
  String categoryId = "";
  String locationId = "";
  String description = "";
  List<String> images = [];
  String ownerId = "";
  int? likes = 0;
  int? dislikes = 0;
}
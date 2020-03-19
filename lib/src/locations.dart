import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

@JsonSerializable()
class ParkingSlot {
  ParkingSlot({
    this.lat,
    this.lng,
    this.space
  });

  factory ParkingSlot.fromJson(Map<String, dynamic> json) => _$ParkingSlotFromJson(json);
  Map<String, dynamic> toJson() => _$ParkingSlotToJson(this);

  final String lat;
  final String lng;
  final String space;
}

@JsonSerializable()
class ParkingSlots {
  ParkingSlots({
    this.parkingSlots
  });

  factory ParkingSlots.fromJson(Map<String, dynamic> json) => _$ParkingSlotsFromJson(json);
  Map<String, dynamic> toJson() => _$ParkingSlotsToJson(this);

  final List<ParkingSlot> parkingSlots;
}

Future<ParkingSlots> getParkingSlots() async {
  const parkingSlotsURL = 'https://myprojiot.000webhostapp.com/www/getParkingPoints.php';

  // Retrieve the locations of Google offices
  final response = await http.get(parkingSlotsURL);
  if (response.statusCode == 200) {
    return ParkingSlots.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
            ' ${response.reasonPhrase}',
        uri: Uri.parse(parkingSlotsURL));
  }
}
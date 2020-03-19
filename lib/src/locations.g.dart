// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingSlot _$ParkingSlotFromJson(Map<String, dynamic> json) {
  return ParkingSlot(
      lat: json['lat'] as String,
      lng: json['lng'] as String,
      space: json['space'] as String);
}

Map<String, dynamic> _$ParkingSlotToJson(ParkingSlot instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'space': instance.space
    };

ParkingSlots _$ParkingSlotsFromJson(Map<String, dynamic> json) {
  return ParkingSlots(
      parkingSlots: (json['parking_points'] as List)
          ?.map((e) => e == null
              ? null
              : ParkingSlot.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ParkingSlotsToJson(ParkingSlots instance) =>
    <String, dynamic>{'parking_points': instance.parkingSlots};

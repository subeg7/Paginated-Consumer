// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passenger_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassengerResponseModel _$PassengerResponseModelFromJson(
    Map<String, dynamic> json) {
  return PassengerResponseModel(
    json['name'] as String,
    json['trips'] as int,
  );
}

Map<String, dynamic> _$PassengerResponseModelToJson(
        PassengerResponseModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'trips': instance.trips,
    };

part "passenger_response_model.g.dart";

class PassengerResponseModel {
  final String name;
  final int trips;

  PassengerResponseModel(
    this.name,
    this.trips,
  );

  factory PassengerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PassengerResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PassengerResponseModelToJson(this);
}

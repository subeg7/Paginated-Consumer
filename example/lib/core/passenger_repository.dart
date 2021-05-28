import 'dart:convert';
import 'dart:io';

import 'package:example/model/passenger_response_model.dart';
import 'package:http/http.dart' as http;

class PassengerRepository {
  final url = "https://api.instantwebtools.net/v1/passenger";

  Future<List<PassengerResponseModel>> getPassengers(
      {int page, int pageSize}) async {
    final response = await http.get(url + "?page=$page&size=$pageSize");
    final dataMap = json.decode(response.body)["data"];
    final List<PassengerResponseModel> passengers =
        List<PassengerResponseModel>.generate(
      dataMap.length,
      (index) => PassengerResponseModel.fromJson(
        dataMap[index],
      ),
    );
    return passengers;
  }
}

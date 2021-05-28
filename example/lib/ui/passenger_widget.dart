import 'package:example/model/passenger_response_model.dart';
import 'package:flutter/material.dart';

class PassengerWidget extends StatelessWidget {
  final PassengerResponseModel passenger;
  final int id;

  const PassengerWidget({Key key, this.passenger, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      elevation: 5.0,
      child: Container(
        // color: Colors.grey,
        height: 70,
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Text("$id  Name  : "),
            Text("${passenger.name}",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Spacer(),
            Text(
              "Trips : ${passenger.trips}",
            ),
          ],
        ),
      ),
    );
  }
}

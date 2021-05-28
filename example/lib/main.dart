import 'package:flutter/material.dart';
import 'package:paginated_consumer/paginated_consumer.dart';
import 'package:paginated_consumer/pagination_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

//**
// ....................... example showing the pagination of list of airline passengers .................
//
// */

void main() {
  runApp(MyApp());
}

//**
// ....................... Models & Providers .................
//
// */

class PassengerProvider extends PaginationProvider<PassengerResponseModel> {
  final PassengerRepository _repository = PassengerRepository();

  PassengerProvider()
      : super.fromInitialOption(
          PaginationInitialOption(
            initialRefresh: true,
            initialPage: 414,
            sizePerPage: 20,
          ),
        );

  @override
  Future<List<PassengerResponseModel>> fetchByPage(
          {int page, int pageSize}) async =>
      await _repository.getPassengers(page: page, pageSize: pageSize);
}

class PassengerResponseModel {
  final String name;
  final int trips;

  PassengerResponseModel(
    this.name,
    this.trips,
  );

  factory PassengerResponseModel.fromJson(Map<String, dynamic> json) =>
      PassengerResponseModel(
        json['name'] as String,
        json['trips'] as int,
      );
}

//**
// ....................... Repository calling api .................
//
// */

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

//**
// ....................... VIEWS & UI .................
//
// */
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: InitialScreen(),
    );
  }
}

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagination Example"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (_) => PassengerProvider(),
                child: PassengerScreen(),
              ),
            ),
          ),
          child: Text("See list of passengers"),
        ),
      ),
    );
  }
}

//**
// ..................... Screen Showing Pagination Example.................
//
// */
class PassengerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of passengers"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: PaginatedConsumer<PassengerProvider>(
          builder: (context, provider) {
            return ListView.builder(
              itemCount: provider.dataList.length,
              itemBuilder: (context, index) => PassengerWidget(
                passenger: provider.dataList[index],
                id: index + 1,
              ),
            );
          },
        ),
      ),
    );
  }
}

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

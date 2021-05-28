import 'package:example/core/passenger_provider.dart';
import 'package:example/ui/passenger_widget.dart';
import 'package:flutter/material.dart';
import 'package:paginated_consumer/paginated_consumer.dart';

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

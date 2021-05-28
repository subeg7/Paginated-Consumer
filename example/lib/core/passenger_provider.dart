import 'package:example/core/passenger_repository.dart';
import 'package:example/model/passenger_response_model.dart';
import 'package:paginated_consumer/pagination_provider.dart';

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

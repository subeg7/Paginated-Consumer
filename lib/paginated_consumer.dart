import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'abstract_pagination_provider.dart';

class PaginatedConsumer<T> extends StatelessWidget {
  final Function builder;
  final bool enablePullUp;
  final bool enablePullDown;
  final Widget header;

  const PaginatedConsumer({
    Key key,
    this.builder,
    this.enablePullUp = true,
    this.enablePullDown = true,
    this.header = const WaterDropHeader(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, paginatedProvider, _) {
        final provider = paginatedProvider as PaginationProvider;
        return SmartRefresher(
          controller: provider.refreshController,
          enablePullDown: true,
          enablePullUp: true,
          header: header,
          onRefresh: () => provider.onRefresh(),
          onLoading: () => provider.onLoadMore(),
          child: builder(context, provider),
        );
      },
    );
  }
}

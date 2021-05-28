import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'constants.dart';

abstract class PaginationProvider<T> extends ChangeNotifier {
  /// default constructor initialized with default values
  PaginationProvider() {
    _sizePerPage = defaultSizePerPage;
    _currentpage = defaultCurrentPage;
    refreshController =
        RefreshController(initialRefresh: defaultInitialRefresh);
  }

  ///  constructor with desired values for pagination
  PaginationProvider.fromInitialOption(
    PaginationInitialOption initialOption,
  ) {
    _currentpage = initialOption.initialPage ?? defaultCurrentPage;
    refreshController = RefreshController(
        initialRefresh: initialOption.initialRefresh ?? defaultInitialRefresh);
    _sizePerPage = initialOption.sizePerPage ?? defaultSizePerPage;
  }

  int _currentpage;
  int _sizePerPage;
  RefreshController refreshController;

  int get _nextPage =>
      _currentpage + 1; // page is only updated if the api hit was successful
  List<T> _dataList = [];
  List<T> get dataList => List.unmodifiable(_dataList);
  List<T> _newPageItems = [];
  List<T> get newPageItems => List.unmodifiable(_newPageItems);

  // must be overriden
  Future<List<T>> fetchByPage({@required int page, @required int pageSize});

  void onRefresh() {
    _dataList.clear();
    fetchAndSetRefresher(page: 1);
  }

  void onLoadMore() => fetchAndSetRefresher(page: _nextPage);

  Future<void> fetchAndSetRefresher({@required page}) async {
    try {
      _newPageItems = await fetchByPage(page: page, pageSize: _sizePerPage);
      handlePaginationData(page);
      notifyListeners();
      setApiSuccessRefresher();
    } catch (e) {
      setApiFailedRefresher();
    }
  }

  handlePaginationData(page) {
    this._currentpage = page; // page is updated if the api hit was successful
    if (this.newPageItems.isNotEmpty) {
      this._dataList.addAll(newPageItems);
    }
  }

  setApiSuccessRefresher() {
    if (newPageItems.isNotEmpty) {
      _setRefresherCompleteWithData();
    } else {
      _setRefresherEmptyWithNoData();
    }
  }

  setApiFailedRefresher() {
    if (_currentpage == 1)
      refreshController.refreshFailed();
    else
      refreshController.loadFailed();
  }

  _setRefresherCompleteWithData() {
    if (_currentpage == 1)
      refreshController.refreshCompleted();
    else
      refreshController.loadComplete();
  }

  _setRefresherEmptyWithNoData() {
    if (_currentpage == 1)
      refreshController.refreshCompleted();
    else
      refreshController.loadNoData();
  }
}

class PaginationInitialOption {
  int initialPage = defaultCurrentPage;
  int sizePerPage = defaultSizePerPage;
  bool initialRefresh = defaultInitialRefresh;
}

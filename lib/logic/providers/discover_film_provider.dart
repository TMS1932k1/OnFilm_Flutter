import 'dart:math';

import 'package:flutter/material.dart';
import 'package:onfilm_app/models/films_response.dart';
import 'package:onfilm_app/repositories/repository.dart';

class DiscoverFilmProvider with ChangeNotifier {
  FilmsResponse? _response;
  int _pageCurrent = 1;
  String? _filmType;
  String? _sortBy;
  int? _genre;

  FilmsResponse? get response => _response;
  int get pageCurrent => _pageCurrent;

  DiscoverFilmProvider();

  DiscoverFilmProvider.update(
    this._response,
    this._filmType,
    this._sortBy,
    this._genre,
    this._pageCurrent,
  );

  Future<void> fetchApi() async {
    _response = await Repository().getDiscover(
      _filmType!,
      _sortBy!,
      _pageCurrent,
      _genre!,
    );
  }

  void nextPage() {
    final total = response!.totalPage;
    if (pageCurrent + 1 <= min(500, total)) {
      _pageCurrent += 1;
      notifyListeners();
    }
  }

  void backPage() {
    if (pageCurrent - 1 >= 1) {
      _pageCurrent -= 1;
      notifyListeners();
    }
  }

  void stepLastPage() {
    final total = response!.totalPage;
    if (_pageCurrent != min(500, total)) {
      _pageCurrent = min(500, total);
      notifyListeners();
    }
  }

  void stepFirstPage() {
    if (_pageCurrent != 1) {
      _pageCurrent = 1;
      notifyListeners();
    }
  }
}

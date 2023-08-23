import 'dart:math';

import 'package:flutter/material.dart';
import 'package:onfilm_app/models/films_response.dart';
import 'package:onfilm_app/repositories/repository.dart';

class SearchFilmProvider with ChangeNotifier {
  FilmsResponse? _response;
  String _query = '';
  int _pageCurrent = 1;

  FilmsResponse? get response => _response;

  int get pageCurrent => _pageCurrent;

  set query(String query) {
    _query = query;
    _pageCurrent = 1;
    notifyListeners();
  }

  Future<void> fetchApi() async {
    _response = await Repository().getSearch(_query, _pageCurrent);
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

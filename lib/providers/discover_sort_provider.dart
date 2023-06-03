import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/app_constant.dart';
import 'package:onfilm_app/models/film.dart';

class DiscoverSortProvider with ChangeNotifier {
  Map<String, String> filmType = AppConstant.filmTypes[0];

  List<Map<String, String>> _sortBys = AppConstant.sortMovie;
  int _indexCurrent = 0;

  int get indexCurrent => _indexCurrent;

  set indexCurrent(int index) {
    _indexCurrent = index;
    notifyListeners();
  }

  Map<String, String> get sortBy => _sortBys[_indexCurrent];

  List<Map<String, String>> get sortBys => _sortBys;

  DiscoverSortProvider();

  DiscoverSortProvider.update(this.filmType)
      : _sortBys = filmType['text'] == FilmType.Movie.name
            ? AppConstant.sortMovie
            : AppConstant.sortTVShow,
        _indexCurrent = 0;
}

import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/app_constant.dart';

class DiscoverGenreProvider with ChangeNotifier {
  Map<String, String> _filmType = AppConstant.filmTypes[0];
  var _indexCurrent = 0;

  Map<String, String> get filmType => _filmType;

  int get indexCurrent => _indexCurrent;

  DiscoverGenreProvider();

  DiscoverGenreProvider.update(this._filmType) : _indexCurrent = 0;

  set indexCurrent(int index) {
    _indexCurrent = index;
    notifyListeners();
  }
}

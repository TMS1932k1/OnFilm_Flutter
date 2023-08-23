import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/app_constant.dart';

class DiscoverFilmTypeProvider with ChangeNotifier {
  final List<Map<String, String>> _filmTypes = AppConstant.filmTypes;
  var _indexCurrent = 0;

  List<Map<String, String>> get filmTypes => [..._filmTypes];

  int get indexCurrent => _indexCurrent;

  Map<String, String> get filmType => filmTypes[indexCurrent];

  set indexCurrent(int index) {
    _indexCurrent = index;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:onfilm_app/models/genres_response.dart';
import 'package:onfilm_app/repositories/repository.dart';

class GenreProvider with ChangeNotifier {
  GenresResponse? _responseMovie;
  GenresResponse? _responseTVSHow;

  GenresResponse? get responseMovie => _responseMovie;
  GenresResponse? get responseTVSHow => _responseTVSHow;

  Future<void> fetchApi() async {
    _responseMovie = await Repository().getGenreMovie();
    _responseTVSHow = await Repository().getGenreTVShow();
    notifyListeners();
  }
}

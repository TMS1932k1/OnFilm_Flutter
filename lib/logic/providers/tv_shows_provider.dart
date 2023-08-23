import 'package:flutter/material.dart';
import 'package:onfilm_app/models/films_response.dart';
import 'package:onfilm_app/repositories/repository.dart';

class TVShowsProvider with ChangeNotifier {
  FilmsResponse? _responseTrend;
  FilmsResponse? _responseAiringToday;
  FilmsResponse? _responseTopRated;
  FilmsResponse? _responsePopular;
  FilmsResponse? _responseOnAir;

  FilmsResponse? get responseOnAir => _responseOnAir;

  FilmsResponse? get responsePopular => _responsePopular;

  FilmsResponse? get responseTopRated => _responseTopRated;

  FilmsResponse? get responseAiringToday => _responseAiringToday;

  FilmsResponse? get responseTrend => _responseTrend;

  Future<void> fetchApi() async {
    _responseTrend = await Repository().getTrendTVShow();
    _responseAiringToday = await Repository().getAiringTodayTVShow(1);
    _responseTopRated = await Repository().getTopRatedTVShow(1);
    _responsePopular = await Repository().getPopularTVShow(1);
    _responseOnAir = await Repository().getOnAirTVShow(1);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:onfilm_app/models/films_response.dart';
import 'package:onfilm_app/repositories/repository.dart';

class MoviesProvider with ChangeNotifier {
  FilmsResponse? _responseTrend;
  FilmsResponse? _responseNowPlaying;
  FilmsResponse? _responseTopRated;
  FilmsResponse? _responseUpcoming;
  FilmsResponse? _responsePopular;

  FilmsResponse? get responsePopular => _responsePopular;

  FilmsResponse? get responseUpcoming => _responseUpcoming;

  FilmsResponse? get responseTopRated => _responseTopRated;

  FilmsResponse? get responseNowPlaying => _responseNowPlaying;

  FilmsResponse? get responseTrend => _responseTrend;

  Future<void> fetchApi() async {
    _responseTrend = await Repository().getTrendMovie();
    _responseNowPlaying = await Repository().getNowPlayingMovie(1);
    _responseTopRated = await Repository().getTopRatedMovie(1);
    _responseUpcoming = await Repository().getUpcomingMovie(1);
    _responsePopular = await Repository().getPopularMovie(1);
    notifyListeners();
  }
}

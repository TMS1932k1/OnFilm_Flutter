import 'package:onfilm_app/models/detail_movie.dart';

class DetailMovieResponse {
  final DetailMovie? _detailMovie;
  final String? _error;

  DetailMovie? get detailMovie => _detailMovie;

  String? get error => _error;

  DetailMovieResponse.fromJson(Map<String, dynamic> json)
      : _detailMovie = DetailMovie.fromJson(json),
        _error = null;

  DetailMovieResponse.withError(String mesError)
      : _detailMovie = null,
        _error = mesError;
}

import 'package:onfilm_app/models/film.dart';

class FilmsResponse {
  final int _totalPage;
  final int _page;
  final List<Film> _films;
  final String? _error;

  int get totalPage => _totalPage;
  int get page => _page;
  List<Film> get films => _films;
  String? get error => _error;

  FilmsResponse.fromJsonWithFilmType(
      Map<String, dynamic> json, FilmType filmType)
      : _films = (json['results'] as List)
            .map((result) => Film.fromJson(result, filmType))
            .toList(),
        _page = json['page'],
        _totalPage = json['total_pages'],
        _error = null;

  FilmsResponse.fromJsonWithoutFilmType(Map<String, dynamic> json)
      : _films = (json['results'] as List)
            .where((result) => (result['media_type'] == 'movie' ||
                result['media_type'] == 'tv'))
            .toList()
            .map(
              (result) => Film.fromJson(
                  result,
                  result['media_type'] == 'movie'
                      ? FilmType.Movie
                      : FilmType.TVShow),
            )
            .toList(),
        _page = json['page'],
        _totalPage = json['total_pages'],
        _error = null;

  FilmsResponse.withError(String mesError)
      : _films = [],
        _page = 0,
        _totalPage = 0,
        _error = mesError;
}

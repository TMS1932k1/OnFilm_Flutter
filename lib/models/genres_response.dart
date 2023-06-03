import 'genre.dart';

class GenresResponse {
  final List<Genre> genres;
  final String? error;

  GenresResponse.fromJson(Map<String, dynamic> json)
      : genres = (json['genres'] as List)
            .map((genre) => Genre.fromJson(genre))
            .toList(),
        error = null;

  GenresResponse.withError(String mesError)
      : genres = [],
        error = mesError;
}

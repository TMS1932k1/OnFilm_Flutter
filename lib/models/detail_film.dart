import 'package:onfilm_app/models/genre.dart';

class DetailFilm {
  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String originalLanguage;
  final String overview;
  final String? tagline;
  final num popularity;
  final String? posterPath;
  final num voteCount;
  final num voteAverage;

  DetailFilm({
    required this.posterPath,
    required this.genres,
    required this.overview,
    required this.id,
    required this.tagline,
    required this.originalLanguage,
    required this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.voteAverage,
  });

  DetailFilm.fromJson(Map<String, dynamic> json)
      : posterPath = json['poster_path'],
        overview = json['overview'],
        id = json['id'],
        genres = (json['genres'] as List)
            .map((genre) => Genre.fromJson(genre))
            .toList(),
        originalLanguage = json['original_language'],
        tagline = json['tagline'],
        backdropPath = json['backdrop_path'],
        popularity = json['popularity'],
        voteCount = json['vote_count'],
        voteAverage = json['vote_average'];
}

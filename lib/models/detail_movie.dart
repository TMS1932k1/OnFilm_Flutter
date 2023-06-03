import 'package:onfilm_app/models/detail_film.dart';
import 'package:onfilm_app/models/genre.dart';

class DetailMovie extends DetailFilm {
  final String? releaseDate;
  final int? runtime;
  final bool video;
  final String title;

  DetailMovie({
    required String posterPath,
    required List<Genre> genres,
    required String overview,
    required this.releaseDate,
    required int id,
    required this.runtime,
    required String originalLanguage,
    required this.title,
    required String? tagline,
    required this.video,
    required String backdropPath,
    required num popularity,
    required num voteCount,
    required num voteAverage,
  }) : super(
          backdropPath: backdropPath,
          genres: genres,
          id: id,
          originalLanguage: originalLanguage,
          overview: overview,
          popularity: popularity,
          tagline: tagline,
          posterPath: posterPath,
          voteAverage: voteAverage,
          voteCount: voteCount,
        );

  DetailMovie.fromJson(Map<String, dynamic> json)
      : releaseDate = json['release_date'],
        runtime = json['runtime'],
        video = json['video'],
        title = json['title'],
        super.fromJson(json);
}

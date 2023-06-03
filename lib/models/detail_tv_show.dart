import 'package:onfilm_app/models/detail_film.dart';
import 'package:onfilm_app/models/genre.dart';

class DetailTVShow extends DetailFilm {
  final String? firstAirDate;
  final String name;
  final List<int> episodeRunTime;
  final int numberEpisodes;
  final int numberSeasons;

  DetailTVShow({
    required String posterPath,
    required List<Genre> genres,
    required String overview,
    required this.firstAirDate,
    required int id,
    required String originalLanguage,
    required this.name,
    required this.episodeRunTime,
    required String backdropPath,
    required num popularity,
    required num voteCount,
    required String tagline,
    required num voteAverage,
    required this.numberEpisodes,
    required this.numberSeasons,
  }) : super(
          backdropPath: backdropPath,
          genres: genres,
          id: id,
          originalLanguage: originalLanguage,
          overview: overview,
          popularity: popularity,
          posterPath: posterPath,
          tagline: tagline,
          voteAverage: voteAverage,
          voteCount: voteCount,
        );

  DetailTVShow.fromJson(Map<String, dynamic> json)
      : firstAirDate = json['first_air_date'],
        name = json['name'],
        numberEpisodes = json['number_of_episodes'],
        numberSeasons = json['number_of_seasons'],
        episodeRunTime = (json['episode_run_time'] as List)
            .map((time) => time as int)
            .toList(),
        super.fromJson(json);
}

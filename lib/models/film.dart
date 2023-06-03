enum FilmType {
  Movie,
  TVShow,
}

class Film {
  final String? posterPath;
  final String overview;
  final String? releaseDate;
  final int id;
  final String originalLanguage;
  final String title;
  final String? backdropPath;
  final num popularity;
  final num voteCount;
  final num voteAverage;
  final FilmType filmType;

  Film({
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.id,
    required this.originalLanguage,
    required this.title,
    required this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.voteAverage,
    required this.filmType,
  });

  Film.fromJson(Map<String, dynamic> json, this.filmType)
      : posterPath = json['poster_path'],
        overview = json['overview'],
        releaseDate = filmType == FilmType.Movie
            ? json['release_date']
            : json['first_air_date'],
        id = json['id'],
        originalLanguage = json['original_language'],
        title = filmType == FilmType.Movie ? json['title'] : json['name'],
        backdropPath = json['backdrop_path'],
        popularity = json['popularity'],
        voteCount = json['vote_count'],
        voteAverage = json['vote_average'];
}

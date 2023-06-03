import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:onfilm_app/constants/app_constant.dart';
import 'package:onfilm_app/models/cast_response.dart';
import 'package:onfilm_app/models/detail_movie_response.dart';
import 'package:onfilm_app/models/detail_tv_show_response.dart';
import 'package:onfilm_app/models/film.dart';
import 'package:onfilm_app/models/films_response.dart';
import 'package:onfilm_app/models/genres_response.dart';
import 'package:onfilm_app/models/status_error.dart';
import 'package:onfilm_app/models/video_response.dart';

class Repository {
  final keyApi = 'f90de261f857a41df2afc9ed89187dfe';

  // Url get movies
  final topRatedMovieUrl = 'https://api.themoviedb.org/3/movie/top_rated';
  final nowPlayingMovieUrl = 'https://api.themoviedb.org/3/movie/now_playing';
  final popularMovieUrl = 'https://api.themoviedb.org/3/movie/popular';
  final upcomingMovieUrl = 'https://api.themoviedb.org/3/movie/upcoming';
  final trendMovieUrl = 'https://api.themoviedb.org/3/trending/movie/week';

  // Url get tvshows
  final topRatedTVShowUrl = 'https://api.themoviedb.org/3/tv/top_rated';
  final airingTodayTVShowUrl = 'https://api.themoviedb.org/3/tv/airing_today';
  final onAirTVShowUrl = 'https://api.themoviedb.org/3/tv/on_the_air';
  final popularTVShowUrl = 'https://api.themoviedb.org/3/tv/popular';
  final trendTVShowUrl = 'https://api.themoviedb.org/3/trending/tv/week';

  // Url get discover
  final discoverUrl = 'https://api.themoviedb.org/3/discover/';

  // Url get genre
  final genreTVShowUrl = 'https://api.themoviedb.org/3/genre/tv/list';
  final genreMovieUrl = 'https://api.themoviedb.org/3/genre/movie/list';

  // Url get search multi
  final searchUrl = 'https://api.themoviedb.org/3/search/multi';

  // Url get datail movie
  final detailMovieUrl = 'https://api.themoviedb.org/3/movie';

  // Url get datail tv show
  final detailTVShowUrl = 'https://api.themoviedb.org/3/tv';

  // GET top rated movie
  Future<FilmsResponse> getTopRatedMovie(int page) async {
    Uri url = Uri.parse(
        '$topRatedMovieUrl?api_key=$keyApi&language=en-US&page=$page');
    try {
      final response = await http.get(url);

      // Throw error with tmdb error
      if (response.statusCode > 400) {
        throw StatusErrorException(response.statusCode);
      }

      final data = json.decode(response.body);
      return FilmsResponse.fromJsonWithFilmType(
          data as Map<String, dynamic>, FilmType.Movie);
    } catch (error) {
      print(error.toString());
      return FilmsResponse.withError("Failed in fetch API");
    }
  }

  // GET now playing movie
  Future<FilmsResponse> getNowPlayingMovie(int page) async {
    Uri url = Uri.parse(
        '$nowPlayingMovieUrl?api_key=$keyApi&language=en-US&page=$page');
    try {
      final response = await http.get(url);

      // Throw error with tmdb error
      if (response.statusCode > 400) {
        throw StatusErrorException(response.statusCode);
      }

      final data = json.decode(response.body);
      return FilmsResponse.fromJsonWithFilmType(
          data as Map<String, dynamic>, FilmType.Movie);
    } catch (error) {
      print(error.toString());
      return FilmsResponse.withError("Failed in fetch API");
    }
  }

  // GET popular movie
  Future<FilmsResponse> getPopularMovie(int page) async {
    Uri url =
        Uri.parse('$popularMovieUrl?api_key=$keyApi&language=en-US&page=$page');
    try {
      final response = await http.get(url);

      // Throw error with tmdb error
      if (response.statusCode > 400) {
        throw StatusErrorException(response.statusCode);
      }

      final data = json.decode(response.body);
      return FilmsResponse.fromJsonWithFilmType(
          data as Map<String, dynamic>, FilmType.Movie);
    } catch (error) {
      print(error.toString());
      return FilmsResponse.withError("Failed in fetch API");
    }
  }

  // GET trend movie
  Future<FilmsResponse> getTrendMovie() async {
    Uri url = Uri.parse('$trendMovieUrl?api_key=$keyApi');
    try {
      final response = await http.get(url);

      // Throw error with tmdb error
      if (response.statusCode > 400) {
        throw StatusErrorException(response.statusCode);
      }

      final data = json.decode(response.body);
      return FilmsResponse.fromJsonWithFilmType(
          data as Map<String, dynamic>, FilmType.Movie);
    } catch (error) {
      print(error.toString());
      return FilmsResponse.withError("Failed in fetch API");
    }
  }

  // GET Upcoming movie
  Future<FilmsResponse> getUpcomingMovie(int page) async {
    Uri url = Uri.parse(
        '$upcomingMovieUrl?api_key=$keyApi&language=en-US&page=$page');
    try {
      final response = await http.get(url);

      // Throw error with tmdb error
      if (response.statusCode > 400) {
        throw StatusErrorException(response.statusCode);
      }

      final data = json.decode(response.body);
      return FilmsResponse.fromJsonWithFilmType(
          data as Map<String, dynamic>, FilmType.Movie);
    } catch (error) {
      print(error.toString());
      return FilmsResponse.withError("Failed in fetch API");
    }
  }

  // GET genre Movie
  Future<GenresResponse> getGenreMovie() async {
    Uri url = Uri.parse('$genreMovieUrl?api_key=$keyApi&language=en-US');
    try {
      final response = await http.get(url);

      // Throw error with tmdb error
      if (response.statusCode > 400) {
        throw StatusErrorException(response.statusCode);
      }

      final data = json.decode(response.body);
      return GenresResponse.fromJson(data as Map<String, dynamic>);
    } catch (error) {
      print(error.toString());
      return GenresResponse.withError('Failed in fetch API');
    }
  }

  // GET trend TVShow
  Future<FilmsResponse> getTrendTVShow() async {
    Uri url = Uri.parse('$trendTVShowUrl?api_key=$keyApi');
    try {
      final response = await http.get(url);

      // Throw error with tmdb error
      if (response.statusCode > 400) {
        throw StatusErrorException(response.statusCode);
      }

      final data = json.decode(response.body);
      return FilmsResponse.fromJsonWithFilmType(
          data as Map<String, dynamic>, FilmType.TVShow);
    } catch (error) {
      print(error.toString());
      return FilmsResponse.withError('Failed in fetch API');
    }
  }

  // GET Airing Today TVShow
  Future<FilmsResponse> getAiringTodayTVShow(int page) async {
    Uri url = Uri.parse(
        '$airingTodayTVShowUrl?api_key=$keyApi&language=en-US&page=$page');
    try {
      final response = await http.get(url);

      // Throw error with tmdb error
      if (response.statusCode > 400) {
        throw StatusErrorException(response.statusCode);
      }

      final data = json.decode(response.body);
      return FilmsResponse.fromJsonWithFilmType(
          data as Map<String, dynamic>, FilmType.TVShow);
    } catch (error) {
      print(error.toString());
      return FilmsResponse.withError('Failed in fetch API');
    }
  }

  // GET Popular TVShow
  Future<FilmsResponse> getPopularTVShow(int page) async {
    Uri url = Uri.parse(
        '$popularTVShowUrl?api_key=$keyApi&language=en-US&page=$page');
    try {
      final response = await http.get(url);

      // Throw error with tmdb error
      if (response.statusCode > 400) {
        throw StatusErrorException(response.statusCode);
      }

      final data = json.decode(response.body);
      return FilmsResponse.fromJsonWithFilmType(
          data as Map<String, dynamic>, FilmType.TVShow);
    } catch (error) {
      print(error.toString());
      return FilmsResponse.withError('Failed in fetch API');
    }
  }

  // GET Top Rated TVShow
  Future<FilmsResponse> getTopRatedTVShow(int page) async {
    Uri url = Uri.parse(
        '$topRatedTVShowUrl?api_key=$keyApi&language=en-US&page=$page');
    try {
      final response = await http.get(url);

      // Throw error with tmdb error
      if (response.statusCode > 400) {
        throw StatusErrorException(response.statusCode);
      }

      final data = json.decode(response.body);
      return FilmsResponse.fromJsonWithFilmType(
          data as Map<String, dynamic>, FilmType.TVShow);
    } catch (error) {
      print(error.toString());
      return FilmsResponse.withError('Failed in fetch API');
    }
  }

  // GET On The Air TVShow
  Future<FilmsResponse> getOnAirTVShow(int page) async {
    Uri url =
        Uri.parse('$onAirTVShowUrl?api_key=$keyApi&language=en-US&page=$page');
    try {
      final response = await http.get(url);

      // Throw error with tmdb error
      if (response.statusCode > 400) {
        throw StatusErrorException(response.statusCode);
      }

      final data = json.decode(response.body);
      return FilmsResponse.fromJsonWithFilmType(
          data as Map<String, dynamic>, FilmType.TVShow);
    } catch (error) {
      print(error.toString());
      return FilmsResponse.withError('Failed in fetch API');
    }
  }

  // GET genre TVShow
  Future<GenresResponse> getGenreTVShow() async {
    Uri url = Uri.parse('$genreTVShowUrl?api_key=$keyApi&language=en-US');
    try {
      final response = await http.get(url);

      // Throw error with tmdb error
      if (response.statusCode > 400) {
        throw StatusErrorException(response.statusCode);
      }

      final data = json.decode(response.body);
      return GenresResponse.fromJson(data as Map<String, dynamic>);
    } catch (error) {
      print(error.toString());
      return GenresResponse.withError('Failed in fetch API');
    }
  }

  // GET discover film
  Future<FilmsResponse> getDiscover(
    String filmType,
    String sortBy,
    int page,
    int genre,
  ) async {
    try {
      Uri url = Uri.parse(
          '$discoverUrl/$filmType?api_key=$keyApi&language=en-US&sort_by=$sortBy&page=$page&with_genres=$genre&with_watch_monetization_types=flatrate');

      final response = await http.get(url);

      // Throw error with tmdb error
      if (response.statusCode > 400) {
        throw StatusErrorException(response.statusCode);
      }

      final data = json.decode(response.body);
      if (filmType == AppConstant.filmTypes[0]['query']) {
        return FilmsResponse.fromJsonWithFilmType(
            data as Map<String, dynamic>, FilmType.Movie);
      } else {
        return FilmsResponse.fromJsonWithFilmType(
            data as Map<String, dynamic>, FilmType.TVShow);
      }
    } catch (error) {
      print(error.toString());
      return FilmsResponse.withError('Failed in fetch API');
    }
  }

  // GET search film
  Future<FilmsResponse> getSearch(String query, int page) async {
    try {
      Uri url = Uri.parse(
          '$searchUrl?api_key=$keyApi&language=en-US&query=$query&page=$page&include_adult=false');

      final response = await http.get(url);

      // Throw error with tmdb error
      if (response.statusCode > 400) {
        throw StatusErrorException(response.statusCode);
      }

      final data = json.decode(response.body);
      return FilmsResponse.fromJsonWithoutFilmType(
          data as Map<String, dynamic>);
    } catch (error) {
      print(error.toString());
      return FilmsResponse.withError('Failed in fetch API');
    }
  }

  // GET detail movie
  Future<DetailMovieResponse> getDetailMovie(int id) async {
    try {
      Uri url = Uri.parse('$detailMovieUrl/$id?api_key=$keyApi&language=en-US');

      final response = await http.get(url);

      // Throw error with tmdb error
      if (response.statusCode > 400) {
        throw StatusErrorException(response.statusCode);
      }

      final data = json.decode(response.body);
      return DetailMovieResponse.fromJson(data as Map<String, dynamic>);
    } catch (error) {
      print(error.toString());
      return DetailMovieResponse.withError('Failed in fetch API');
    }
  }

  // GET detail tv show
  Future<DetailTVShowResponse> getDetailTVShow(int id) async {
    try {
      Uri url =
          Uri.parse('$detailTVShowUrl/$id?api_key=$keyApi&language=en-US');

      final response = await http.get(url);

      // Throw error with tmdb error
      if (response.statusCode > 400) {
        throw StatusErrorException(response.statusCode);
      }

      final data = json.decode(response.body);
      return DetailTVShowResponse.fromJson(data as Map<String, dynamic>);
    } catch (error) {
      print(error.toString());
      return DetailTVShowResponse.withError('Failed in fetch API');
    }
  }

  // GET cast
  Future<CastResponse> getCast(int id, bool isMobile) async {
    try {
      Uri url = isMobile
          ? Uri.parse(
              '$detailMovieUrl/$id/credits?api_key=$keyApi&language=en-US')
          : Uri.parse(
              '$detailTVShowUrl/$id/credits?api_key=$keyApi&language=en-US');

      final response = await http.get(url);

      // Throw error with tmdb error
      if (response.statusCode > 400) {
        throw StatusErrorException(response.statusCode);
      }

      final data = json.decode(response.body);
      return CastResponse.fromJson(data as Map<String, dynamic>);
    } catch (error) {
      print(error.toString());
      return CastResponse.withError('Failed in fetch API');
    }
  }

  // GET similar
  Future<FilmsResponse> getSimilar(int id, bool isMovie) async {
    Uri url = isMovie
        ? Uri.parse(
            '$detailMovieUrl/$id/similar?api_key=$keyApi&language=en-US')
        : Uri.parse(
            '$detailTVShowUrl/$id/similar?api_key=$keyApi&language=en-US');
    try {
      final response = await http.get(url);

      // Throw error with tmdb error
      if (response.statusCode > 400) {
        throw StatusErrorException(response.statusCode);
      }

      final data = json.decode(response.body);
      return FilmsResponse.fromJsonWithFilmType(data as Map<String, dynamic>,
          isMovie ? FilmType.Movie : FilmType.TVShow);
    } catch (error) {
      print(error.toString());
      return FilmsResponse.withError('Failed in fetch API');
    }
  }

  // GET video
  Future<VideoResponse> getVideo(int id, bool isMovie) async {
    Uri url = isMovie
        ? Uri.parse('$detailMovieUrl/$id/videos?api_key=$keyApi&language=en-US')
        : Uri.parse(
            '$detailTVShowUrl/$id/videos?api_key=$keyApi&language=en-US');

    try {
      final response = await http.get(url);

      // Throw error with tmdb error
      if (response.statusCode > 400) {
        throw StatusErrorException(response.statusCode);
      }

      final data = json.decode(response.body);
      return VideoResponse.fromJson(data);
    } catch (error) {
      print(error.toString());
      return VideoResponse.withError('Failed in fetch API');
    }
  }
}

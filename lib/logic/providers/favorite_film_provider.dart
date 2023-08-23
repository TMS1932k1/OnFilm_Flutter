import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/app_constant.dart';
import 'package:onfilm_app/models/detail_movie.dart';
import 'package:onfilm_app/models/detail_tv_show.dart';
import 'package:onfilm_app/models/film.dart';
import 'package:onfilm_app/repositories/repository.dart';

class FavoriteFilmProvider with ChangeNotifier {
  final List<Map<String, String>> _filmTypes = AppConstant.filmTypes;
  List<Film> _films = [];
  var _indexCurrent = 0;

  List<Map<String, String>> get filmTypes => [..._filmTypes];

  int get indexCurrent => _indexCurrent;

  Map<String, String> get filmType => filmTypes[indexCurrent];

  List<Film> get films => _films;

  set indexCurrent(int index) {
    _indexCurrent = index;
    notifyListeners();
  }

  Future<void> fetchMovieApi(
    QueryDocumentSnapshot<Map<String, dynamic>> e,
  ) async {
    final movie = await Repository().getDetailMovie(int.parse(e.data()['id']));
    if (movie.error == null) {
      _films.add(convertDetailMovieToFilm(movie.detailMovie!));
    }
  }

  Future<void> fetchTVShowApi(
    QueryDocumentSnapshot<Map<String, dynamic>> e,
  ) async {
    final tv = await Repository().getDetailTVShow(int.parse(e.data()['id']));
    if (tv.error == null) {
      _films.add(convertDetailTVShowToFilm(tv.detailTVShow!));
    }
  }

  // To convert class DetailMovie to Film
  Film convertDetailMovieToFilm(DetailMovie detail) {
    return Film(
      posterPath: detail.posterPath,
      overview: detail.overview,
      releaseDate: detail.releaseDate,
      id: detail.id,
      originalLanguage: detail.originalLanguage,
      title: detail.title,
      backdropPath: detail.backdropPath,
      popularity: detail.popularity,
      voteCount: detail.voteCount,
      voteAverage: detail.voteAverage,
      filmType: FilmType.Movie,
    );
  }

  // To convert class DetailTVShow to Film
  Film convertDetailTVShowToFilm(DetailTVShow detail) {
    return Film(
      posterPath: detail.posterPath,
      overview: detail.overview,
      releaseDate: detail.firstAirDate,
      id: detail.id,
      originalLanguage: detail.originalLanguage,
      title: detail.name,
      backdropPath: detail.backdropPath,
      popularity: detail.popularity,
      voteCount: detail.voteCount,
      voteAverage: detail.voteAverage,
      filmType: FilmType.TVShow,
    );
  }

  Future<void> getDataFromFirebase() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      final value = await FirebaseFirestore.instance
          .collection(uid)
          .where(
            'type',
            isEqualTo: _filmTypes[_indexCurrent]['text'],
          )
          .get();
      _films.clear();
      if (_indexCurrent == 0) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> v in value.docs) {
          await fetchMovieApi(v);
        }
      } else {
        for (QueryDocumentSnapshot<Map<String, dynamic>> v in value.docs) {
          await fetchTVShowApi(v);
        }
      }
    }
  }
}

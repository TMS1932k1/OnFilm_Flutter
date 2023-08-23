import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onfilm_app/models/cast_response.dart';
import 'package:onfilm_app/models/detail_movie_response.dart';
import 'package:onfilm_app/models/detail_tv_show_response.dart';
import 'package:onfilm_app/models/films_response.dart';
import 'package:onfilm_app/models/video_response.dart';
import 'package:onfilm_app/repositories/repository.dart';

class DetailFilmProvider with ChangeNotifier {
  DetailMovieResponse? _responseMovie;
  DetailTVShowResponse? _responseTVShow;
  CastResponse? _responseCast;
  FilmsResponse? _responseSimilar;
  VideoResponse? _responseVideos;
  bool _isFavorited = false;
  bool _isLoading = false;

  DetailMovieResponse? get responseMovie => _responseMovie;

  DetailTVShowResponse? get responseTVShow => _responseTVShow;

  FilmsResponse? get responseFilm => _responseSimilar;

  CastResponse? get responseCast => _responseCast;

  VideoResponse? get responseVideos => _responseVideos;

  bool get isFavorited => _isFavorited;

  bool get isLoading => _isLoading;

  set isFavorited(bool isFavorited) {
    _isFavorited = isFavorited;
    notifyListeners();
  }

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  // Set data with param:
  // + Map<String, String> data: is data need to save
  Future<void> setData(
      String id, Map<String, String> data, Function() error) async {
    await FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc(id)
        .set(data);
    checkFavorited(id);
  }

  // Delete data with param:
  // + String doc: name doc needed to delete
  Future<void> delDoc(String id, Function() error) async {
    await FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc(id)
        .delete();
    checkFavorited(id);
  }

  Future<void> checkFavorited(String idFilm) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection(user.uid)
          .doc(idFilm)
          .get()
          .then((value) {
        if (value.exists) {
          isFavorited = true;
        } else {
          isFavorited = false;
        }
      });
    }
  }

  Future<void> fetchMovieApi(int id) async {
    _responseMovie = await Repository().getDetailMovie(id);
    _responseCast = await Repository().getCast(id, true);
    _responseSimilar = await Repository().getSimilar(id, true);
    _responseVideos = await Repository().getVideo(id, true);
    notifyListeners();
  }

  Future<void> fetchTvApi(int id) async {
    _responseTVShow = await Repository().getDetailTVShow(id);
    _responseCast = await Repository().getCast(id, false);
    _responseSimilar = await Repository().getSimilar(id, false);
    _responseVideos = await Repository().getVideo(id, false);
    notifyListeners();
  }
}

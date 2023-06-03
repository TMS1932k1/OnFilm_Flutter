import 'package:onfilm_app/models/detail_movie.dart';
import 'package:onfilm_app/models/detail_tv_show.dart';

class DetailTVShowResponse {
  final DetailTVShow? _detailTVShow;
  final String? _error;

  DetailTVShow? get detailTVShow => _detailTVShow;

  String? get error => _error;

  DetailTVShowResponse.fromJson(Map<String, dynamic> json)
      : _detailTVShow = DetailTVShow.fromJson(json),
        _error = null;

  DetailTVShowResponse.withError(String mesError)
      : _detailTVShow = null,
        _error = mesError;
}

import 'package:onfilm_app/models/cast.dart';

class CastResponse {
  List<Cast> _casts = [];
  final String? _error;

  List<Cast> get casts => [..._casts];

  String? get error => _error;

  CastResponse.fromJson(Map<String, dynamic> json)
      : _casts = (json['cast'] as List<dynamic>)
            .map((json) => Cast.fromJson(json))
            .toList(),
        _error = null;

  CastResponse.withError(String mesError)
      : _casts = [],
        _error = mesError;
}

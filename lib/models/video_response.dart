import 'package:onfilm_app/models/video.dart';

class VideoResponse {
  final List<Video> videos;
  final String? error;

  VideoResponse.fromJson(Map<String, dynamic> json)
      : videos = (json['results'] as List)
            .map((video) => Video.fromJson(video))
            .toList(),
        error = null;

  VideoResponse.withError(String mesError)
      : videos = [],
        error = mesError;
}

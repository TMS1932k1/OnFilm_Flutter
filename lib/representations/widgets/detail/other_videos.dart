import 'package:flutter/material.dart';
import 'package:onfilm_app/models/video.dart';
import 'package:onfilm_app/representations/widgets/detail/video_item.dart';

class OrtherVideos extends StatelessWidget {
  final List<Video> videos;
  final void Function(Video)? selectVideo;
  final int indexCurrent;
  final String name;

  const OrtherVideos(
    this.videos,
    this.selectVideo,
    this.indexCurrent,
    this.name, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...videos
              .map(
                (video) => GestureDetector(
                  onTap: selectVideo != null ? () => selectVideo!(video) : null,
                  child: VideoItem(
                    videos.indexOf(video) == indexCurrent,
                    video,
                    name,
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

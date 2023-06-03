import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/models/video.dart';
import 'package:onfilm_app/representations/widgets/detail/info_video.dart';
import 'package:onfilm_app/representations/widgets/detail/option_bar.dart';
import 'package:onfilm_app/representations/widgets/detail/other_videos.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final List<Video> videos;
  final PageController pageController;
  final String name;

  const VideoScreen(
    this.videos,
    this.name,
    this.pageController, {
    super.key,
  });

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;
  int _indexCurrent = 0;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videos[_indexCurrent].key,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get device size
    final sizeDevice = MediaQuery.of(context).size;

    void _selectNewVideo(Video video) {
      setState(() {
        if (widget.videos.indexOf(video) != _indexCurrent) {
          _indexCurrent = widget.videos.indexOf(video);
          _controller.load(widget.videos[_indexCurrent].key);
        }
      });
    }

    return AnimatedBuilder(
      animation: widget.pageController,
      builder: (context, child) {
        // Set value init and update where scroll pageview
        double scale = 0;
        if (widget.pageController.position.hasContentDimensions) {
          scale = 1 - widget.pageController.page!;
        }

        return AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: 1 - scale.abs(),
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
            builder: (ctx, player) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: sizeDevice.height * 0.4,
                    child: player,
                  ),
                  const SizedBox(
                    height: DimenssionConstant.kPandingSmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenssionConstant.kPandingSmall,
                    ),
                    child: InfoVideo(
                      widget.videos[_indexCurrent],
                      widget.name,
                    ),
                  ),
                  const SizedBox(
                    height: DimenssionConstant.kPandingLarge,
                  ),
                  Expanded(
                    child: OptionBar(
                      [
                        Option(
                          title: 'Other Videos',
                          content: OrtherVideos(
                            widget.videos,
                            (video) => _selectNewVideo(video),
                            _indexCurrent,
                            widget.name,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

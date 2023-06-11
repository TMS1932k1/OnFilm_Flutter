import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  var isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videos[_indexCurrent].key,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        forceHD: true,
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
          child: _buildContentVertical(
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onEnded: (metaData) => setState(() {
                if (_indexCurrent >= widget.videos.length - 1) {
                  _indexCurrent = 0;
                }
                _indexCurrent++;
                _controller.load(widget.videos[_indexCurrent].key);
              }),
              bottomActions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isFullScreen = !isFullScreen;
                    });
                  },
                  icon: FaIcon(
                    isFullScreen
                        ? FontAwesomeIcons.compress
                        : FontAwesomeIcons.expand,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            sizeDevice,
            widget.videos,
            widget.name,
            _indexCurrent,
            _selectNewVideo,
            isFullScreen,
          ),
        );
      },
    );
  }
}

Widget _buildContentVertical(
  Widget player,
  Size size,
  List<Video> videos,
  String name,
  int indexCurrent,
  void Function(Video video) selectNewVideo,
  bool isFullScreen,
) {
  if (isFullScreen) {
    return Expanded(child: player);
  }

  return Row(
    children: [
      Expanded(
        flex: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: player),
            const SizedBox(
              height: DimenssionConstant.kPandingSmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimenssionConstant.kPandingSmall,
              ),
              child: InfoVideo(
                videos[indexCurrent],
                name,
              ),
            ),
            const SizedBox(
              height: DimenssionConstant.kPandingLarge,
            ),
            if (size.width < 1200)
              Expanded(
                child: _buildOtherVideos(
                    videos, selectNewVideo, indexCurrent, name),
              )
          ],
        ),
      ),
      if (size.width >= 1200)
        Expanded(
          flex: 2,
          child: _buildOtherVideos(videos, selectNewVideo, indexCurrent, name),
        )
    ],
  );
}

Widget _buildOtherVideos(
  List<Video> videos,
  void Function(Video video) selectNewVideo,
  int indexCurrent,
  String name,
) {
  return OptionBar(
    [
      Option(
        title: 'Other Videos',
        content: OrtherVideos(
          videos,
          (video) => selectNewVideo(video),
          indexCurrent,
          name,
        ),
      ),
    ],
  );
}

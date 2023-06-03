import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';
import 'package:onfilm_app/models/cast.dart';
import 'package:onfilm_app/models/detail_film.dart';
import 'package:onfilm_app/models/detail_movie.dart';
import 'package:onfilm_app/models/detail_tv_show.dart';
import 'package:onfilm_app/models/film.dart';
import 'package:onfilm_app/models/video.dart';
import 'package:onfilm_app/providers/detail_film_provider.dart';
import 'package:onfilm_app/representations/widgets/detail/backdrop_image.dart';
import 'package:onfilm_app/representations/widgets/detail/info_bar.dart';
import 'package:onfilm_app/representations/widgets/detail/info_column.dart';
import 'package:onfilm_app/representations/widgets/rated_bar.dart';
import 'package:provider/provider.dart';

class InfoScreen extends StatelessWidget {
  final bool isMovie;
  final PageController pageController;
  final void Function() goToVideo;

  const InfoScreen(
    this.isMovie,
    this.pageController,
    this.goToVideo, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get device size
    final sizeDevice = MediaQuery.of(context).size;

    void _watchVideo() {
      pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }

    // Get detail, cast and similar
    final DetailFilm detail = isMovie
        ? Provider.of<DetailFilmProvider>(context, listen: false)
            .responseMovie!
            .detailMovie!
        : Provider.of<DetailFilmProvider>(context, listen: false)
            .responseTVShow!
            .detailTVShow!;
    final List<Cast> casts =
        Provider.of<DetailFilmProvider>(context, listen: false)
            .responseCast!
            .casts;
    final List<Film> similar =
        Provider.of<DetailFilmProvider>(context, listen: false)
            .responseFilm!
            .films;
    final List<Video> videos =
        Provider.of<DetailFilmProvider>(context, listen: false)
            .responseVideos!
            .videos;

    String? errorVideos =
        Provider.of<DetailFilmProvider>(context, listen: false)
            .responseVideos!
            .error;

    return AnimatedBuilder(
      animation: pageController,
      builder: (ctx, child) {
        // Set value init and update where scroll pageview
        double scale = 0;
        if (pageController.position.hasContentDimensions) {
          scale = 0 - pageController.page!;
        }
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: 1 - scale.abs(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BackdropImage(
                  isMovie,
                  detail,
                  errorVideos == null && videos.isNotEmpty,
                ),
                const SizedBox(height: DimenssionConstant.kPandingSmall),
                _buildInfoBar(ctx, isMovie, detail),
                InfoColumn(
                  detail,
                  casts,
                  similar,
                  sizeDevice.width < 600,
                  isMovie,
                  _watchVideo,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoBar(
    BuildContext context,
    bool isMovie,
    DetailFilm detail,
  ) {
    // Get device size
    final sizeDevice = MediaQuery.of(context).size;

    return InfoBar(
      [
        InfoBarItem(
          'Vote',
          RatedBar(
            detail.voteAverage / 2,
            DimenssionConstant.kIconBtn,
          ),
        ),
        InfoBarItem(
          'Views',
          Text(
            detail.popularity.toStringAsFixed(1),
            style: TextStyleConstant.labelMedium,
          ),
        ),
        InfoBarItem(
          'Duration',
          isMovie
              ? Text(
                  (detail as DetailMovie).runtime != null
                      ? '${(detail).runtime} min'
                      : '--',
                  style: TextStyleConstant.labelMedium,
                )
              : Text(
                  (detail as DetailTVShow).episodeRunTime.isNotEmpty
                      ? '${(detail).episodeRunTime[0]} min'
                      : '--',
                  style: TextStyleConstant.labelMedium,
                ),
        ),
        if (sizeDevice.width >= 600)
          InfoBarItem(
            'Language',
            Text(
              detail.originalLanguage.toUpperCase(),
              style: TextStyleConstant.labelMedium,
            ),
          ),
      ],
    );
  }
}

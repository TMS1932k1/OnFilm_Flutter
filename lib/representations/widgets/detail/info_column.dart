import 'dart:math';

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
import 'package:onfilm_app/representations/widgets/detail/cast_item.dart';
import 'package:onfilm_app/representations/widgets/detail/genre_item.dart';
import 'package:onfilm_app/representations/widgets/detail/info_sesion.dart';
import 'package:onfilm_app/representations/widgets/session_list.dart';
import 'package:provider/provider.dart';

class InfoColumn extends StatelessWidget {
  final DetailFilm detail;
  final List<Cast> casts;
  List<Film> similar;
  final bool isMobile;
  final bool isMovie;
  final void Function() watchVideo;

  InfoColumn(
    this.detail,
    this.casts,
    this.similar,
    this.isMobile,
    this.isMovie,
    this.watchVideo, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Video> videos =
        Provider.of<DetailFilmProvider>(context, listen: false)
            .responseVideos!
            .videos;

    // Check have videos
    bool _isHaveVideo() {
      final error = Provider.of<DetailFilmProvider>(context, listen: false)
          .responseVideos!
          .error;
      final videos = Provider.of<DetailFilmProvider>(context, listen: false)
          .responseVideos!
          .videos;
      if (error == null && videos.isNotEmpty) {
        return true;
      }
      return false;
    }

    return Padding(
      padding: const EdgeInsets.all(DimenssionConstant.kPandingSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: DimenssionConstant.kPandingLarge),
          InfoSesion(
            'Genre',
            SizedBox(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: detail.genres.length,
                itemBuilder: (ctx, index) {
                  return GenreItem(detail.genres[index]);
                },
              ),
            ),
          ),
          const SizedBox(height: DimenssionConstant.kPandingLarge),
          // Show overview
          InfoSesion(
            'Overview',
            Text(
              detail.overview,
              style: TextStyleConstant.labelMedium,
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(height: DimenssionConstant.kPandingLarge),
          // Show release
          if ((isMovie && (detail as DetailMovie).releaseDate != null) ||
              (!isMovie && (detail as DetailTVShow).firstAirDate != null))
            InfoSesion(
              isMovie ? 'Release Date' : 'First Air Date',
              Text(
                isMovie
                    ? (detail as DetailMovie).releaseDate ?? ''
                    : (detail as DetailTVShow).firstAirDate ?? '',
                style: TextStyleConstant.labelMedium,
              ),
            ),
          const SizedBox(height: DimenssionConstant.kPandingLarge),
          // Show language
          if (isMobile)
            InfoSesion(
              'Language',
              Text(
                detail.originalLanguage.toUpperCase(),
                style: TextStyleConstant.labelMedium,
              ),
            ),
          if (isMobile)
            const SizedBox(
              height: DimenssionConstant.kPandingLarge,
            ),
          // Go to video screen
          if (_isHaveVideo())
            InfoSesion(
              'Videos',
              GestureDetector(
                onTap: watchVideo,
                child: Text(
                  'Watch now',
                  style: TextStyleConstant.labelMedium.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          if (_isHaveVideo())
            const SizedBox(
              height: DimenssionConstant.kPandingLarge,
            ),
          // Show cast
          if (casts.isNotEmpty)
            InfoSesion(
              'Cast',
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: casts.length,
                  itemBuilder: (ctx, index) => CastItem(casts[index]),
                ),
              ),
            ),
          if (casts.isNotEmpty)
            const SizedBox(height: DimenssionConstant.kPandingLarge),
          if (similar.isNotEmpty)
            InfoSesion(
              'Similar',
              SizedBox(
                height: isMovie
                    ? DimenssionConstant.kHeightSectionMovie
                    : DimenssionConstant.kHeightSectionTVShow,
                child: SessionList(similar, SessionType.Default),
              ),
            ),
        ],
      ),
    );
  }
}

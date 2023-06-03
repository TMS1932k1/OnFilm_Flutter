import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/colors_constant.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';
import 'package:onfilm_app/models/detail_film.dart';
import 'package:onfilm_app/models/detail_movie.dart';
import 'package:onfilm_app/models/detail_tv_show.dart';
import 'package:onfilm_app/representations/widgets/load_image.dart';

class BackdropImage extends StatelessWidget {
  final bool isMovie;
  final DetailFilm detail;
  final bool isHaveVideo;

  const BackdropImage(
    this.isMovie,
    this.detail,
    this.isHaveVideo, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get device size
    final sizeDevice = MediaQuery.of(context).size;

    return SizedBox(
      height: sizeDevice.height * 0.35,
      width: double.infinity,
      child: GridTile(
        footer: Container(
          height: sizeDevice.height * 0.25,
          padding: const EdgeInsets.all(
            DimenssionConstant.kPandingMedium,
          ),
          decoration: const BoxDecoration(
            gradient: ColorsConstant.gradientBottomToTop,
          ),
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Text(
                    isMovie
                        ? (detail as DetailMovie).title
                        : (detail as DetailTVShow).name,
                    style: TextStyleConstant.headlineLarge.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (detail.tagline != null && detail.tagline!.isNotEmpty)
                    const SizedBox(height: DimenssionConstant.kPandingSmall),
                  if (detail.tagline != null && detail.tagline!.isNotEmpty)
                    Text(
                      '" ${detail.tagline!} "',
                      style: TextStyleConstant.labelMedium.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 1),
          child: LoadImage(
            detail.backdropPath,
            sizeDevice.width >= 600,
            BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onfilm_app/constants/colors_constant.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/models/film.dart';
import 'package:onfilm_app/representations/screens/detail/detail_screen.dart';
import 'package:onfilm_app/representations/widgets/rated_bar.dart';

class FooterSlider extends StatelessWidget {
  final Film film;
  final BoxConstraints constraints;
  final Widget posterImage;
  final int index;
  final PageController pageController;

  const FooterSlider(
    this.film,
    this.constraints,
    this.posterImage,
    this.index,
    this.pageController, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: constraints.maxHeight * 0.6,
      padding: const EdgeInsets.all(
        DimenssionConstant.kPandingMedium,
      ),
      decoration: const BoxDecoration(
        gradient: ColorsConstant.gradientBottomToTop,
      ),
      child: AnimatedBuilder(
        animation: pageController,
        builder: (ctx, child) {
          // Set value init and update where scroll pageview
          double scale = 0;
          if (pageController.position.hasContentDimensions) {
            scale = index - pageController.page!;
          }

          return Transform.scale(
            scale: 1 - scale.abs(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (constraints.maxWidth >= DimenssionConstant.kMaxWidthMobile)
                  _buildPosterImage(context, posterImage),
                if (constraints.maxWidth >= DimenssionConstant.kMaxWidthMobile)
                  const SizedBox(
                    width: DimenssionConstant.kPandingMedium,
                  ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          film.title.length < 30
                              ? film.title.toUpperCase()
                              : '${film.title.substring(0, 30).toUpperCase()}...',
                          style: Theme.of(context).textTheme.headlineLarge!,
                        ),
                        const SizedBox(
                          height: DimenssionConstant.kPandingSmall,
                        ),
                        Text(
                          '${film.popularity.toStringAsFixed(2)} views - ${film.originalLanguage.toUpperCase()}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                        const SizedBox(
                          height: DimenssionConstant.kPandingSmall,
                        ),
                        Row(
                          children: [
                            RatedBar(
                              film.voteAverage / 2,
                              DimenssionConstant.kIconBtn,
                            ),
                            const SizedBox(
                              width: DimenssionConstant.kPandingSmall,
                            ),
                            Text(
                              '${film.voteAverage.toStringAsFixed(1)} points',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.normal,
                                  ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: DimenssionConstant.kPandingSmall,
                        ),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => Navigator.of(context).pushNamed(
                                DetailScreen.nameRoute,
                                arguments: {
                                  'id': film.id,
                                  'type': film.filmType,
                                },
                              ),
                              icon: const FaIcon(
                                FontAwesomeIcons.play,
                                size: DimenssionConstant.kIconBtn,
                              ),
                              label: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: DimenssionConstant.kPandingMedium,
                                ),
                                child: Text(
                                  'Watch',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: DimenssionConstant.kPandingSmall,
                            ),
                            Text(
                              film.releaseDate != null ? film.releaseDate! : '',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _buildPosterImage(
  BuildContext context,
  Widget posterImage,
) {
  return Container(
    height: DimenssionConstant.kHeightPosterSlider,
    width: DimenssionConstant.kWidthPosterSlider,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.background,
      borderRadius: BorderRadius.circular(
        DimenssionConstant.kRadiusMedium,
      ),
      boxShadow: const [
        BoxShadow(
          blurRadius: 10,
          color: Colors.white,
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(
        DimenssionConstant.kRadiusMedium,
      ),
      child: posterImage,
    ),
  );
}

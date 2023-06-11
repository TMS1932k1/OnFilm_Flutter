import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';
import 'package:onfilm_app/models/film.dart';
import 'package:onfilm_app/representations/screens/detail/detail_screen.dart';
import 'package:onfilm_app/representations/widgets/load_image.dart';
import 'package:onfilm_app/representations/widgets/rated_bar.dart';

class TopSessionVerticalItem extends StatelessWidget {
  final Film film;
  final int top;

  const TopSessionVerticalItem(
    this.film,
    this.top, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        DetailScreen.nameRoute,
        arguments: {
          'id': film.id,
          'type': film.filmType,
        },
      ),
      child: Container(
        // Cases with type is movie or tvshow
        height: DimenssionConstant.kHeightPosterImage / 3 * 2,
        margin: const EdgeInsets.all(
          DimenssionConstant.kPandingSmall,
        ),
        child: SizedBox(
          height: DimenssionConstant.kHeightPosterImage,
          child: Row(
            children: [
              SizedBox(
                width: 30,
                child: Text(
                  top.toString(),
                  maxLines: 2,
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: DimenssionConstant.kPandingSmall),
              SizedBox(
                width: DimenssionConstant.kWidthPosterImage / 3 * 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    DimenssionConstant.kRadiusSmall,
                  ),
                  child: LoadImage(
                    film.posterPath,
                    false,
                    BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(width: DimenssionConstant.kPandingSmall),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      film.title.length < 40
                          ? film.title
                          : '${film.title.substring(0, 25)}...',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: DimenssionConstant.kPandingSmall),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            DimenssionConstant.kPandingLarge,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: DimenssionConstant.kPandingSmall,
                            ),
                            color: Theme.of(context).colorScheme.primary,
                            child: Text(
                              film.voteAverage.toStringAsFixed(1),
                              style: TextStyleConstant.labelMedium.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: DimenssionConstant.kPandingSmall),
                        RatedBar(
                          film.voteAverage as double,
                          DimenssionConstant.kIconBtn,
                        ),
                      ],
                    ),
                    const SizedBox(height: DimenssionConstant.kPandingSmall),
                    Text(
                      film.releaseDate != null ? film.releaseDate! : '',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Row(
//           children: [
//             Expanded(
//               flex: 1,
//               child: Text(
//                 '$top',
//                 style: TextStyleConstant.labelLarge,
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(
//                           DimenssionConstant.kPandingSmall),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(
//                           DimenssionConstant.kRadiusSmall,
//                         ),
//                         child: LoadImage(
//                           film.posterPath,
//                           false,
//                           BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: DimenssionConstant.kPandingSmall),
//                   SizedBox(
//                     height: DimenssionConstant.kHeightTitleFilm,
//                     width: DimenssionConstant.kWidthPosterImage,
//                     child: Text(
//                       textAlign: TextAlign.center,
//                       film.title.length < 25
//                           ? film.title
//                           : '${film.title.substring(0, 25)}...',
//                       maxLines: 2,
//                       style: Theme.of(context).textTheme.labelSmall,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),

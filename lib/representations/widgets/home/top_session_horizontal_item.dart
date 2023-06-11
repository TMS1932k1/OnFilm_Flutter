import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';
import 'package:onfilm_app/models/film.dart';
import 'package:onfilm_app/representations/screens/detail/detail_screen.dart';
import 'package:onfilm_app/representations/widgets/load_image.dart';

class TopSessionHorizontalItem extends StatelessWidget {
  final Film film;
  final int top;

  const TopSessionHorizontalItem(
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
        width: top <= 9
            ? DimenssionConstant.kWidthPosterImage * 3 / 2 +
                DimenssionConstant.kPandingSmall
            : DimenssionConstant.kWidthPosterImage,
        margin: const EdgeInsets.symmetric(
          horizontal: DimenssionConstant.kPandingSmall,
        ),
        child: Row(
          children: [
            if (top <= 9)
              Expanded(
                flex: 1,
                child: Text(
                  '$top',
                  style: TextStyleConstant.numberTop,
                ),
              ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(
                          DimenssionConstant.kPandingSmall),
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
                  ),
                  const SizedBox(height: DimenssionConstant.kPandingSmall),
                  SizedBox(
                    height: DimenssionConstant.kHeightTitleFilm,
                    width: DimenssionConstant.kWidthPosterImage,
                    child: Text(
                      textAlign: TextAlign.center,
                      film.title.length < 25
                          ? film.title
                          : '${film.title.substring(0, 25)}...',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

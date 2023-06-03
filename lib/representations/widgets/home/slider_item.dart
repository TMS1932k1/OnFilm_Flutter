import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/models/film.dart';
import 'package:onfilm_app/representations/widgets/load_image.dart';
import 'package:onfilm_app/representations/widgets/home/footer_slider.dart';

class SliderItem extends StatelessWidget {
  final Film film;
  final int index;
  final PageController pageController;

  const SliderItem(
    this.film,
    this.index,
    this.pageController, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, contraints) => GridTile(
        footer: FooterSlider(
          film,
          contraints,
          LoadImage(film.posterPath, false, BoxFit.fill),
          index,
          pageController,
        ),
        child: contraints.maxWidth < DimenssionConstant.kMaxWidthMobile
            ? LoadImage(film.posterPath, false, BoxFit.cover)
            : LoadImage(film.backdropPath, true, BoxFit.cover),
      ),
    );
  }
}

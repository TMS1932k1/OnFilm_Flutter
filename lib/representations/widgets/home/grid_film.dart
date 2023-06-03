import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/models/film.dart';
import 'package:onfilm_app/representations/widgets/default_session_item.dart';

class GridFilm extends StatelessWidget {
  final List<Film> films;

  const GridFilm(
    this.films, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(
        DimenssionConstant.kPandingSmall,
      ),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: DimenssionConstant.kWidthGrid,
        crossAxisSpacing: DimenssionConstant.kPandingSmall,
        mainAxisSpacing: DimenssionConstant.kPandingSmall,
        mainAxisExtent: DimenssionConstant.kHeihthGrid,
      ),
      itemBuilder: (ctx, index) {
        return DefaultSessionItem(films[index], false);
      },
      itemCount: films.length,
    );
  }
}

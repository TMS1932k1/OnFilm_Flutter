import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';
import 'package:onfilm_app/models/genre.dart';

class GenreItem extends StatelessWidget {
  final Genre genre;
  const GenreItem(this.genre, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(
        right: DimenssionConstant.kPandingSmall,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: DimenssionConstant.kPandingSmall,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          DimenssionConstant.kRadiusSmall,
        ),
        border: Border.all(color: Colors.white),
      ),
      child: Text(
        genre.name,
        style: TextStyleConstant.labelSmall,
      ),
    );
  }
}

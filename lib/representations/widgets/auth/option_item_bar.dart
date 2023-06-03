import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';

class OptionItemBar extends StatelessWidget {
  final String title;
  final bool isCurrent;

  const OptionItemBar(
    this.title,
    this.isCurrent, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.symmetric(
        vertical: DimenssionConstant.kPandingSmall,
        horizontal: DimenssionConstant.kPandingMedium,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(DimenssionConstant.kRadiusSmall),
          topRight: Radius.circular(DimenssionConstant.kRadiusSmall),
        ),
        color: isCurrent
            ? Theme.of(context).colorScheme.primary
            : Colors.transparent,
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyleConstant.headlineMedium.copyWith(
          color: isCurrent
              ? Theme.of(context).colorScheme.background
              : Colors.grey,
          fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

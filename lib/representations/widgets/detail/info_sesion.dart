import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';

class InfoSesion extends StatelessWidget {
  final String title;
  final Widget content;
  const InfoSesion(this.title, this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyleConstant.labelLarge.copyWith(
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: DimenssionConstant.kPandingSmall),
        content,
      ],
    );
  }
}

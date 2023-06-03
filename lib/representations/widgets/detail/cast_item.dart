import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';
import 'package:onfilm_app/models/cast.dart';
import 'package:onfilm_app/representations/widgets/load_image.dart';

class CastItem extends StatelessWidget {
  final Cast cast;
  const CastItem(this.cast, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 90,
      margin: const EdgeInsets.only(
        right: DimenssionConstant.kPandingSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: LoadImage(
              cast.profilePath,
              false,
              BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: DimenssionConstant.kPandingSmall,
          ),
          SizedBox(
            height: 30,
            child: Text(
              cast.name,
              style: TextStyleConstant.labelSmall,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

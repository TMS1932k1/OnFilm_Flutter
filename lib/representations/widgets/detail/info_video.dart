import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';
import 'package:onfilm_app/models/video.dart';

class InfoVideo extends StatelessWidget {
  final Video video;
  final String name;
  const InfoVideo(
    this.video,
    this.name, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '[${video.type}] ${video.name} | $name',
          style: TextStyleConstant.headlineLarge,
        ),
        const SizedBox(
          height: DimenssionConstant.kPandingSmall,
        ),
        Text(
          '${DateTime.now().difference(
                DateTime.parse(
                  video.publishedAt,
                ),
              ).inDays} days ago - ${video.language.toUpperCase()} - ${video.country} - ${video.size}p',
          style: TextStyleConstant.labelSmall.copyWith(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

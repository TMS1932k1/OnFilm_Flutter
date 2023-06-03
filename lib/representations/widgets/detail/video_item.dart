import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/assets_constant.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';
import 'package:onfilm_app/models/video.dart';

class VideoItem extends StatelessWidget {
  final bool isCurrent;
  final Video video;
  final String name;

  const VideoItem(
    this.isCurrent,
    this.video,
    this.name, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sizeDevice = MediaQuery.of(context).size;

    return Container(
      height: sizeDevice.height * 0.13,
      margin: const EdgeInsets.only(
        bottom: DimenssionConstant.kPandingSmall,
      ),
      padding: EdgeInsets.all(
        isCurrent
            ? DimenssionConstant.kPandingSmall
            : DimenssionConstant.kPandingMedium,
      ),
      child: Container(
        decoration: isCurrent
            ? BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(
                  DimenssionConstant.kRadiusSmall,
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 7,
                    color: Colors.white,
                  ),
                ],
              )
            : null,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            DimenssionConstant.kRadiusSmall,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: const AssetImage(
                    AssetsConstant.playHolderImage,
                  ),
                  image: NetworkImage(
                      'https://img.youtube.com/vi/${video.key}/0.jpg'),
                  imageErrorBuilder: (context, error, stackTrace) =>
                      Image.asset(
                    AssetsConstant.playHolderImage,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(
                      left: DimenssionConstant.kPandingSmall),
                  child: '[${video.type}] ${video.name} | $name'.length < 80
                      ? Text(
                          '[${video.type}] ${video.name} | $name',
                          style: TextStyleConstant.labelMedium,
                        )
                      : Text(
                          '${'[${video.type}] ${video.name} | $name'.substring(0, 80).trim()}...',
                          style: TextStyleConstant.labelMedium,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

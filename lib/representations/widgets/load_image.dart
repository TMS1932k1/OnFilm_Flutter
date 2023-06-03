import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/app_constant.dart';
import 'package:onfilm_app/constants/assets_constant.dart';

class LoadImage extends StatelessWidget {
  final String? path;
  final bool isOriginnal;
  final BoxFit boxFit;

  const LoadImage(
    this.path,
    this.isOriginnal,
    this.boxFit, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (path != null) {
      return FadeInImage(
        fit: boxFit,
        placeholder: const AssetImage(AssetsConstant.playHolderImage),
        image: NetworkImage(
          isOriginnal
              ? AppConstant.baseOriginalImageUrl + path!
              : AppConstant.baseW500ImageUrl + path!,
        ),
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            AssetsConstant.playHolderImage,
            fit: boxFit,
          );
        },
      );
    } else {
      return Center(
        child: Image.asset(
          AssetsConstant.playHolderImage,
          fit: boxFit,
        ),
      );
    }
  }
}

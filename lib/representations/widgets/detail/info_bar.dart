import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';

class InfoBar extends StatelessWidget {
  final List<InfoBarItem> contents;
  const InfoBar(this.contents, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ...contents
            .map(
              (item) => Column(
                children: [
                  Text(
                    item.title,
                    style: TextStyleConstant.labelMedium.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: DimenssionConstant.kPandingSmall),
                  item.content,
                ],
              ),
            )
            .toList(),
      ],
    );
  }
}

class InfoBarItem {
  String title;
  Widget content;

  InfoBarItem(
    this.title,
    this.content,
  );
}

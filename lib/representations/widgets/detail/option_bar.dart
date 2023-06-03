import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';

class OptionBar extends StatefulWidget {
  final List<Option> tabs;

  const OptionBar(
    this.tabs, {
    super.key,
  });

  @override
  State<OptionBar> createState() => _OptionBarState();
}

class Option {
  final String title;
  final Widget content;

  Option({
    required this.title,
    required this.content,
  });
}

class _OptionBarState extends State<OptionBar> {
  int indecCurrent = 0;

  void onClickOption(int index) {
    if (index != indecCurrent) {
      setState(() {
        indecCurrent = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: widget.tabs
              .map(
                (tab) => Container(
                  margin: const EdgeInsets.only(
                    right: DimenssionConstant.kPandingSmall,
                  ),
                  child: TextButton(
                    onPressed: () => onClickOption(
                      widget.tabs.indexOf(tab),
                    ),
                    child: Text(
                      tab.title.toUpperCase(),
                      style: TextStyleConstant.labelMedium.copyWith(
                        color: indecCurrent == widget.tabs.indexOf(tab)
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white,
                        fontWeight: indecCurrent == widget.tabs.indexOf(tab)
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        Expanded(
          child: widget.tabs[indecCurrent].content,
        ),
      ],
    );
  }
}

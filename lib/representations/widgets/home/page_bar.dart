import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';

class PageBar extends StatelessWidget {
  final Widget textPageCurrent;
  final void Function() nextPage;
  final void Function() backPage;
  final void Function() stepLastPage;
  final void Function() stepFirstPage;

  const PageBar({
    required this.textPageCurrent,
    required this.nextPage,
    required this.backPage,
    required this.stepLastPage,
    required this.stepFirstPage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        DimenssionConstant.kPandingSmall,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: stepFirstPage,
            icon: const FaIcon(
              FontAwesomeIcons.backwardStep,
              color: Colors.white,
              size: DimenssionConstant.kIconBtn,
            ),
          ),
          IconButton(
            onPressed: backPage,
            icon: const FaIcon(
              FontAwesomeIcons.backward,
              color: Colors.white,
              size: DimenssionConstant.kIconBtn,
            ),
          ),
          Container(
            width: 40,
            alignment: Alignment.center,
            child: textPageCurrent,
          ),
          IconButton(
            onPressed: nextPage,
            icon: const FaIcon(
              FontAwesomeIcons.forward,
              color: Colors.white,
              size: DimenssionConstant.kIconBtn,
            ),
          ),
          IconButton(
            onPressed: stepLastPage,
            icon: const FaIcon(
              FontAwesomeIcons.forwardStep,
              color: Colors.white,
              size: DimenssionConstant.kIconBtn,
            ),
          ),
        ],
      ),
    );
  }
}

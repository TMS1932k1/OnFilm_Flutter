import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';

class DiscoverSortBar extends StatefulWidget {
  final List<Widget> paramList;
  const DiscoverSortBar(
    this.paramList, {
    super.key,
  });

  @override
  State<DiscoverSortBar> createState() => _DiscoverSortBarState();
}

class _DiscoverSortBarState extends State<DiscoverSortBar>
    with SingleTickerProviderStateMixin {
  var _isCollapse = true;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedContainer(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(DimenssionConstant.kPandingSmall),
      height: _isCollapse ? 65 : 265,
      constraints: BoxConstraints(
          minHeight: _isCollapse
              ? DimenssionConstant.kHeightDiscoverTitle
              : DimenssionConstant.kHeightDiscoverTitle +
                  DimenssionConstant.kHeightDiscoverBar),
      child: size.width < 600
          ? Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Sort with',
                      style: TextStyleConstant.headlineSmall,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_isCollapse) {
                            _controller.forward();
                          } else {
                            _controller.reverse();
                          }
                          _isCollapse = !_isCollapse;
                        });
                      },
                      icon: _isCollapse
                          ? const FaIcon(FontAwesomeIcons.caretDown)
                          : const FaIcon(FontAwesomeIcons.caretUp),
                      color: Colors.white,
                      iconSize: DimenssionConstant.kIconBtn,
                    ),
                  ],
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  constraints: BoxConstraints(
                      maxHeight: !_isCollapse
                          ? DimenssionConstant.kHeightDiscoverBar
                          : 0,
                      minHeight: !_isCollapse
                          ? DimenssionConstant.kHeightDiscoverBar
                          : 0),
                  curve: Curves.easeIn,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ...widget.paramList.map((sort) => sort).toList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Row(
              children: [
                const Text(
                  'Sort with',
                  style: TextStyleConstant.headlineSmall,
                ),
                ...widget.paramList.map((sort) => sort).toList(),
              ],
            ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onfilm_app/models/film.dart';
import 'package:onfilm_app/representations/widgets/home/slider_item.dart';

class SliderView extends StatefulWidget {
  final List<Film> films;
  const SliderView(
    this.films, {
    super.key,
  });

  @override
  State<SliderView> createState() => _SliderViewState();
}

class _SliderViewState extends State<SliderView> {
  late PageController _pageController;
  int _currentPage = 0;
  bool isIncreasing = true;
  late Timer _timer;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );

    // Set auto scroll page
    _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
      if ((_currentPage < widget.films.length - 1 && isIncreasing) ||
          (_currentPage > 0 && !isIncreasing)) {
        isIncreasing ? _currentPage++ : _currentPage--;
      } else {
        isIncreasing = !isIncreasing;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (value) => _currentPage = value,
      itemCount: widget.films.length,
      itemBuilder: (ctx, index) {
        final film = widget.films[index];
        return SliderItem(
          film,
          index,
          _pageController,
        );
      },
    );
  }
}

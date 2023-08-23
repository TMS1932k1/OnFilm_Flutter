import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/colors_constant.dart';
import 'package:onfilm_app/models/detail_film.dart';
import 'package:onfilm_app/models/detail_movie.dart';
import 'package:onfilm_app/models/detail_tv_show.dart';
import 'package:onfilm_app/models/film.dart';
import 'package:onfilm_app/models/video.dart';
import 'package:onfilm_app/logic/providers/detail_film_provider.dart';
import 'package:onfilm_app/representations/screens/detail/info_screen.dart';
import 'package:onfilm_app/representations/screens/detail/video_screen.dart';
import 'package:onfilm_app/representations/widgets/circular_progress_loading.dart';
import 'package:onfilm_app/representations/widgets/detail/favorite_button.dart';
import 'package:onfilm_app/representations/widgets/home/error_fetch_api.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  static const nameRoute = '/detail';

  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get argments
    final mapArgument =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final int id = mapArgument['id'];
    final FilmType type = mapArgument['type'];
    final isMovie = type == FilmType.Movie;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: ColorsConstant.gradientTopToBottom,
          ),
        ),
        actions: [
          FavoriteButton(id, type),
        ],
      ),
      body: FutureBuilder(
        future: isMovie
            ? Provider.of<DetailFilmProvider>(context, listen: false)
                .fetchMovieApi(id)
            : Provider.of<DetailFilmProvider>(context, listen: false)
                .fetchTvApi(id),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CirculaProgressLoading();
          }

          // Check failured fetch api
          String? errorDetail = isMovie
              ? Provider.of<DetailFilmProvider>(context, listen: false)
                  .responseMovie!
                  .error
              : Provider.of<DetailFilmProvider>(context, listen: false)
                  .responseTVShow!
                  .error;
          String? errorVideos =
              Provider.of<DetailFilmProvider>(context, listen: false)
                  .responseVideos!
                  .error;

          if (errorDetail != null) {
            return ErrorFetchApi(errorDetail);
          }

          final List<Video> videos =
              Provider.of<DetailFilmProvider>(context, listen: false)
                  .responseVideos!
                  .videos;

          final DetailFilm detail = isMovie
              ? Provider.of<DetailFilmProvider>(context, listen: false)
                  .responseMovie!
                  .detailMovie!
              : Provider.of<DetailFilmProvider>(context, listen: false)
                  .responseTVShow!
                  .detailTVShow!;

          return PageView(
            controller: _pageController,
            children: [
              InfoScreen(isMovie, _pageController, () {
                _pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              }),
              if (errorVideos == null && videos.isNotEmpty)
                VideoScreen(
                  videos,
                  isMovie
                      ? (detail as DetailMovie).title
                      : (detail as DetailTVShow).name,
                  _pageController,
                ),
            ],
          );
        },
      ),
    );
  }
}

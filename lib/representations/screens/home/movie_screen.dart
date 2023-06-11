import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/providers/movies_provider.dart';
import 'package:onfilm_app/representations/widgets/circular_progress_loading.dart';
import 'package:onfilm_app/representations/widgets/home/error_fetch_api.dart';
import 'package:onfilm_app/representations/widgets/session_horizontal_list.dart';
import 'package:onfilm_app/representations/widgets/home/slider_view.dart';
import 'package:onfilm_app/representations/widgets/home/title_session.dart';
import 'package:onfilm_app/representations/widgets/session_vertical_list.dart';
import 'package:provider/provider.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get device's size
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: Provider.of<MoviesProvider>(context, listen: false).fetchApi(),
      builder: (context, snapshot) {
        // When wait fetching api
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CirculaProgressLoading();
        }

        if (size.width >= 1200) {
          return SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Row(
              children: [
                Flexible(
                  flex: 5,
                  child: _buildContentVertical(context, size),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    children: [
                      const TitleSession('Top Rated'),
                      Expanded(child: _buildTopRatedVerticalMovie(context)),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return _buildContentVertical(context, size);
      },
    );
  }
}

Widget _buildContentVertical(BuildContext context, Size size) {
  return SingleChildScrollView(
    child: Column(
      children: [
        // Trend TV Show
        _buildTrendMovie(
          context,
          size.width < 1200 ? size.height * 0.5 : size.height * 0.6,
        ),
        // Now Playing
        const TitleSession('Now Playing'),
        _buildNowPlayingMovie(context),
        if (size.width < 1200)
          // Top Rated
          const TitleSession('Top Rated'),
        if (size.width < 1200) _buildTopRatedHorizontalMovie(context),
        // Upcoming
        const TitleSession('Upcoming'),
        _buildUpcomingMovie(context),
        // Popular
        const TitleSession('Popular'),
        _buildPopularMovie(context),
      ],
    ),
  );
}

// Trend Movie
Widget _buildTrendMovie(BuildContext context, double size) {
  final response =
      Provider.of<MoviesProvider>(context, listen: false).responseTrend;

  return SizedBox(
    height: size,
    child: response!.error != null
        ? ErrorFetchApi(response.error!)
        : SliderView(response.films),
  );
}

// Nowplaing Movie
Widget _buildNowPlayingMovie(BuildContext context) {
  final response =
      Provider.of<MoviesProvider>(context, listen: false).responseNowPlaying;

  return SizedBox(
    height: DimenssionConstant.kHeightSectionMovie,
    child: response!.error != null
        ? ErrorFetchApi(response.error!)
        : SessionHorizontalList(response.films, SessionType.Default),
  );
}

// Top Rated Movie Horizontal
Widget _buildTopRatedHorizontalMovie(BuildContext context) {
  final response =
      Provider.of<MoviesProvider>(context, listen: false).responseTopRated;

  return SizedBox(
    height: DimenssionConstant.kHeightSectionMovie +
        DimenssionConstant.kPandingSmall,
    child: response!.error != null
        ? ErrorFetchApi(response.error!)
        : SessionHorizontalList(response.films, SessionType.Top),
  );
}

// Top Rated Movie Vertical
Widget _buildTopRatedVerticalMovie(BuildContext context) {
  final response =
      Provider.of<MoviesProvider>(context, listen: false).responseTopRated;

  return SizedBox(
    height: double.infinity,
    child: response!.error != null
        ? ErrorFetchApi(response.error!)
        : SessionVerticalList(response.films, SessionType.Top),
  );
}

// Upcoming Movie
Widget _buildUpcomingMovie(BuildContext context) {
  final response =
      Provider.of<MoviesProvider>(context, listen: false).responseUpcoming;

  return SizedBox(
    height: DimenssionConstant.kHeightSectionMovie,
    child: response!.error != null
        ? ErrorFetchApi(response.error!)
        : SessionHorizontalList(response.films, SessionType.Default),
  );
}

// Upcoming Movie
Widget _buildPopularMovie(BuildContext context) {
  final response =
      Provider.of<MoviesProvider>(context, listen: false).responsePopular;

  return SizedBox(
    height: DimenssionConstant.kHeightSectionMovie,
    child: response!.error != null
        ? ErrorFetchApi(response.error!)
        : SessionHorizontalList(response.films, SessionType.Default),
  );
}

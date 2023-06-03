import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/providers/tv_shows_provider.dart';
import 'package:onfilm_app/representations/widgets/circular_progress_loading.dart';
import 'package:onfilm_app/representations/widgets/home/error_fetch_api.dart';
import 'package:onfilm_app/representations/widgets/session_list.dart';
import 'package:onfilm_app/representations/widgets/home/slider_view.dart';
import 'package:onfilm_app/representations/widgets/home/title_session.dart';
import 'package:provider/provider.dart';

class TvShowScreen extends StatelessWidget {
  const TvShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get device's size
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: Provider.of<TVShowsProvider>(context, listen: false).fetchApi(),
      builder: (context, snapshot) {
        // When wait fetching api
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CirculaProgressLoading();
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              // Trend TV Show
              _buildTrendTVShow(
                context,
                size.width < 600 ? size.height * 0.6 : size.height * 0.45,
              ),
              // Airing Today
              const TitleSession('Airing Today'),
              _buildAiringTodayTVShow(context),
              // Top Rated
              const TitleSession('Top Rated'),
              _buildTopRatedTVShow(context),
              // Popular
              const TitleSession('Popular'),
              _buildPopularTVShow(context),
              // On The Air
              const TitleSession('On The Air'),
              _buildOnAirTVShow(context),
            ],
          ),
        );
      },
    );
  }
}

// Trend TVShow
Widget _buildTrendTVShow(BuildContext context, double size) {
  final response =
      Provider.of<TVShowsProvider>(context, listen: false).responseTrend;

  return SizedBox(
    height: size,
    child: response!.error != null
        ? ErrorFetchApi(response.error!)
        : SliderView(response.films),
  );
}

// Airing Today TVShow
Widget _buildAiringTodayTVShow(BuildContext context) {
  final response =
      Provider.of<TVShowsProvider>(context, listen: false).responseAiringToday;

  return SizedBox(
    height: DimenssionConstant.kHeightSectionTVShow,
    child: response!.error != null
        ? ErrorFetchApi(response.error!)
        : SessionList(response.films, SessionType.Default),
  );
}

// Popular TVShow
Widget _buildPopularTVShow(BuildContext context) {
  final response =
      Provider.of<TVShowsProvider>(context, listen: false).responsePopular;
  return SizedBox(
    height: DimenssionConstant.kHeightSectionTVShow,
    child: response!.error != null
        ? ErrorFetchApi(response.error!)
        : SessionList(response.films, SessionType.Default),
  );
}

// Top Rated TVShow
Widget _buildTopRatedTVShow(BuildContext context) {
  final response =
      Provider.of<TVShowsProvider>(context, listen: false).responseTopRated;

  return SizedBox(
    height: DimenssionConstant.kHeightSectionMovie +
        DimenssionConstant.kPandingSmall,
    child: response!.error != null
        ? ErrorFetchApi(response.error!)
        : SessionList(response.films, SessionType.Top),
  );
}

// On The Air TVShow
Widget _buildOnAirTVShow(BuildContext context) {
  final response =
      Provider.of<TVShowsProvider>(context, listen: false).responseOnAir;

  return SizedBox(
    height: DimenssionConstant.kHeightSectionTVShow,
    child: response!.error != null
        ? ErrorFetchApi(response.error!)
        : SessionList(response.films, SessionType.Default),
  );
}

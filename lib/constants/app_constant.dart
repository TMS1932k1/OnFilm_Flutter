import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onfilm_app/representations/screens/home/discover_screen.dart';
import 'package:onfilm_app/representations/screens/home/favorite_screen.dart';
import 'package:onfilm_app/representations/screens/home/movie_screen.dart';
import 'package:onfilm_app/representations/screens/home/tv_show_screen.dart';

class AppConstant {
  static const String baseW500ImageUrl = 'https://image.tmdb.org/t/p/w500/';
  static const String baseOriginalImageUrl =
      'https://image.tmdb.org/t/p/original/';
  static final List<Map<String, dynamic>> pages = [
    {
      'name': 'TV Show',
      'icon': FontAwesomeIcons.tv,
      'page': const TvShowScreen(),
    },
    {
      'name': 'Movie',
      'icon': FontAwesomeIcons.film,
      'page': const MovieScreen(),
    },
    {
      'name': 'Discover',
      'icon': FontAwesomeIcons.globe,
      'page': const DiscoverScreen(),
    },
    {
      'name': 'Favorite',
      'icon': FontAwesomeIcons.heart,
      'page': const FavoriteScreen(),
    },
  ];
  static const List<Map<String, String>> sortMovie = [
    {
      'text': 'Popularity',
      'query': 'popularity.desc',
    },
    {
      'text': 'Vote Average',
      'query': 'vote_average.desc',
    },
    {
      'text': 'Release Date',
      'query': 'release_date.desc',
    },
  ];
  static const List<Map<String, String>> sortTVShow = [
    {
      'text': 'Popularity',
      'query': 'popularity.desc',
    },
    {
      'text': 'Vote Average',
      'query': 'vote_average.desc',
    },
    {
      'text': 'First Air Date',
      'query': 'first_air_date.desc',
    },
  ];
  static const List<Map<String, String>> filmTypes = [
    {
      'text': 'Movie',
      'query': 'movie',
    },
    {
      'text': 'TVShow',
      'query': 'tv',
    },
  ];
}

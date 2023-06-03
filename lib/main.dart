import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/app_constant.dart';
import 'package:onfilm_app/providers/detail_film_provider.dart';
import 'package:onfilm_app/providers/discover_film_provider.dart';
import 'package:onfilm_app/providers/discover_film_type_provider.dart';
import 'package:onfilm_app/providers/discover_genre_provider.dart';
import 'package:onfilm_app/providers/favorite_film_provider.dart';
import 'package:onfilm_app/providers/genre_provider.dart';
import 'package:onfilm_app/providers/movies_provider.dart';
import 'package:onfilm_app/providers/discover_sort_provider.dart';
import 'package:onfilm_app/providers/search_film_provider.dart';
import 'package:onfilm_app/representations/screens/auth/auth_screen.dart';
import 'package:onfilm_app/representations/screens/detail/detail_screen.dart';
import 'package:onfilm_app/representations/screens/search/search_screen.dart';
import 'package:onfilm_app/providers/tv_shows_provider.dart';
import 'package:provider/provider.dart';
import 'package:onfilm_app/constants/colors_constant.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';
import 'package:onfilm_app/representations/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MoviesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TVShowsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DiscoverFilmTypeProvider(),
        ),
        ChangeNotifierProxyProvider<DiscoverFilmTypeProvider,
            DiscoverSortProvider>(
          create: (context) => DiscoverSortProvider(),
          update: (context, value, _) => DiscoverSortProvider.update(
            value.filmType,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => (GenreProvider()),
        ),
        ChangeNotifierProxyProvider<DiscoverFilmTypeProvider,
            DiscoverGenreProvider>(
          create: (context) => DiscoverGenreProvider(),
          update: (context, value, _) => DiscoverGenreProvider.update(
            value.filmType,
          ),
        ),
        ChangeNotifierProxyProvider4<
            DiscoverFilmTypeProvider,
            DiscoverSortProvider,
            DiscoverGenreProvider,
            GenreProvider,
            DiscoverFilmProvider>(
          create: (context) => DiscoverFilmProvider(),
          update: (context, value, value2, value3, value4, previous) =>
              DiscoverFilmProvider.update(
            previous!.response,
            value.filmType['query']!,
            value2.sortBy['query']!,
            value3.filmType == AppConstant.filmTypes[0]
                ? value4.responseMovie!.genres[value3.indexCurrent].id
                : value4.responseTVSHow!.genres[value3.indexCurrent].id,
            1,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchFilmProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailFilmProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteFilmProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'OnFilm Demo',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: ColorsConstant.primaryColor,
            background: ColorsConstant.backgroundColor,
          ),
          textTheme: const TextTheme(
            headlineLarge: TextStyleConstant.headlineLarge,
            headlineMedium: TextStyleConstant.headlineMedium,
            headlineSmall: TextStyleConstant.headlineSmall,
            labelLarge: TextStyleConstant.labelExtra,
            labelMedium: TextStyleConstant.labelLarge,
            labelSmall: TextStyleConstant.labelMedium,
          ),
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          SearchScreen.nameRoute: (context) => const SearchScreen(),
          DetailScreen.nameRoute: (context) => const DetailScreen(),
          AuthScreen.nameRoute: (context) => const AuthScreen(),
        },
      ),
    );
  }
}

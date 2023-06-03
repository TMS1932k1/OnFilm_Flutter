import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/app_constant.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';
import 'package:onfilm_app/models/genre.dart';
import 'package:onfilm_app/providers/discover_film_provider.dart';
import 'package:onfilm_app/providers/discover_film_type_provider.dart';
import 'package:onfilm_app/providers/discover_genre_provider.dart';
import 'package:onfilm_app/providers/genre_provider.dart';
import 'package:onfilm_app/providers/discover_sort_provider.dart';
import 'package:onfilm_app/representations/widgets/circular_progress_loading.dart';
import 'package:onfilm_app/representations/widgets/home/discover_sort_bar.dart';
import 'package:onfilm_app/representations/widgets/home/error_fetch_api.dart';
import 'package:onfilm_app/representations/widgets/home/grid_film.dart';
import 'package:onfilm_app/representations/widgets/home/page_bar.dart';
import 'package:onfilm_app/representations/widgets/home/title_session.dart';
import 'package:provider/provider.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get device's size
    final size = MediaQuery.of(context).size;
    final topPanding = MediaQuery.of(context).padding.top;

    // Onclick next
    void nextPage() =>
        Provider.of<DiscoverFilmProvider>(context, listen: false).nextPage();

    // Onclick back
    void backPage() =>
        Provider.of<DiscoverFilmProvider>(context, listen: false).backPage();

    // Onclick step last page
    void stepLastPage() =>
        Provider.of<DiscoverFilmProvider>(context, listen: false)
            .stepLastPage();

    // Onclick step first page
    void stepFirstPage() =>
        Provider.of<DiscoverFilmProvider>(context, listen: false)
            .stepFirstPage();

    return FutureBuilder(
      future: Provider.of<GenreProvider>(context, listen: false).fetchApi(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              SizedBox(
                height: topPanding,
              ),
              const Expanded(
                child: CirculaProgressLoading(),
              ),
            ],
          );
        }

        // Check failured fetch api
        String? error1 = Provider.of<GenreProvider>(context, listen: false)
            .responseMovie!
            .error;
        String? error2 = Provider.of<GenreProvider>(context, listen: false)
            .responseTVSHow!
            .error;
        if (error1 != null || error2 != null) {
          return ErrorFetchApi(error1 ?? error2!);
        }

        return Column(
          children: [
            SizedBox(
              height: topPanding,
            ),
            DiscoverSortBar(
              [
                // Option type film
                _buildOptionFilmTypeList(ctx, size.width < 600),
                // Option sort by
                _buildOptionSortByList(ctx, size.width < 600),
                // Option genre
                _buildOptionGenreList(ctx, size.width < 600),
              ],
            ),
            const TitleSession('Result'),
            Expanded(
              child: _buildGridResult(context),
            ),
            PageBar(
              textPageCurrent: Consumer<DiscoverFilmProvider>(
                builder: (context, value, _) {
                  return Text(
                    '${value.pageCurrent}',
                    style: TextStyleConstant.labelMedium,
                  );
                },
              ),
              nextPage: nextPage,
              backPage: backPage,
              stepFirstPage: stepFirstPage,
              stepLastPage: stepLastPage,
            ),
          ],
        );
      },
    );
  }
}

Widget _buildGridResult(BuildContext context) {
  return Consumer<DiscoverFilmProvider>(
    builder: (ctx, value, _) {
      return FutureBuilder(
        future:
            Provider.of<DiscoverFilmProvider>(ctx, listen: false).fetchApi(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CirculaProgressLoading();
          }

          // Check failured fetch api
          String? error =
              Provider.of<DiscoverFilmProvider>(context, listen: false)
                  .response!
                  .error;
          if (error != null) {
            return ErrorFetchApi(error);
          }

          final films = Provider.of<DiscoverFilmProvider>(ctx, listen: false)
              .response!
              .films;
          return GridFilm(films);
        },
      );
    },
  );
}

Widget _buildOptionSortByList(BuildContext context, bool isExpanded) {
  return Consumer<DiscoverSortProvider>(builder: (ctx, data, _) {
    return _buildDropdownDecoration(
      DropdownButton<Map<String, String>>(
        value: data.sortBy,
        items: data.sortBys
            .map(
              (item) => DropdownMenuItem<Map<String, String>>(
                value: item,
                child: Text(item['text']!),
              ),
            )
            .toList(),
        onChanged: (value) {
          data.indexCurrent = data.sortBys.indexOf(value!);
        },
        isExpanded: isExpanded,
        style: TextStyleConstant.labelMedium,
        dropdownColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
    );
  });
}

Widget _buildOptionFilmTypeList(BuildContext context, bool isExpanded) {
  return Consumer<DiscoverFilmTypeProvider>(
    builder: (context, data, _) {
      return _buildDropdownDecoration(
        DropdownButton<Map<String, String>>(
          value: data.filmTypes[data.indexCurrent],
          items: data.filmTypes
              .map(
                (item) => DropdownMenuItem<Map<String, String>>(
                  value: item,
                  child: Text(item['text']!),
                ),
              )
              .toList(),
          onChanged: (value) {
            data.indexCurrent = data.filmTypes.indexOf(value!);
          },
          isExpanded: isExpanded,
          style: TextStyleConstant.labelMedium,
          dropdownColor: Theme.of(context).colorScheme.background,
          elevation: 0,
        ),
      );
    },
  );
}

Widget _buildOptionGenreList(BuildContext context, bool isExpanded) {
  return Consumer<DiscoverGenreProvider>(
    builder: (context, data, _) {
      final genresData = Provider.of<GenreProvider>(context, listen: false);
      return _buildDropdownDecoration(
        DropdownButton<Genre>(
          value: data.filmType == AppConstant.filmTypes[0]
              ? genresData.responseMovie!.genres[data.indexCurrent]
              : genresData.responseTVSHow!.genres[data.indexCurrent],
          items: (data.filmType == AppConstant.filmTypes[0]
                  ? genresData.responseMovie!.genres
                  : genresData.responseTVSHow!.genres)
              .map(
                (item) => DropdownMenuItem<Genre>(
                  value: item,
                  child: Text(item.name),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (data.filmType == AppConstant.filmTypes[0]) {
              data.indexCurrent =
                  genresData.responseMovie!.genres.indexOf(value!);
            }
            if (data.filmType == AppConstant.filmTypes[1]) {
              data.indexCurrent =
                  genresData.responseTVSHow!.genres.indexOf(value!);
            }
          },
          isExpanded: isExpanded,
          style: TextStyleConstant.labelMedium,
          dropdownColor: Theme.of(context).colorScheme.background,
          elevation: 0,
        ),
      );
    },
  );
}

// Decoration dropdown
Widget _buildDropdownDecoration(DropdownButton dropdownButton) {
  return Container(
    margin: const EdgeInsets.all(
      DimenssionConstant.kPandingSmall,
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: DimenssionConstant.kPandingMedium,
    ),
    height: 50,
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.grey,
      ),
      borderRadius: BorderRadius.circular(
        DimenssionConstant.kRadiusSmall,
      ),
    ),
    child: DropdownButtonHideUnderline(child: dropdownButton),
  );
}

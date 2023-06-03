import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';
import 'package:onfilm_app/providers/search_film_provider.dart';
import 'package:onfilm_app/representations/widgets/circular_progress_loading.dart';
import 'package:onfilm_app/representations/widgets/home/error_fetch_api.dart';
import 'package:onfilm_app/representations/widgets/home/grid_film.dart';
import 'package:onfilm_app/representations/widgets/home/page_bar.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const nameRoute = '/search';

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;

  // Onclick next
  void nextPage() =>
      Provider.of<SearchFilmProvider>(context, listen: false).nextPage();

  // Onclick back
  void backPage() =>
      Provider.of<SearchFilmProvider>(context, listen: false).backPage();

  // Onclick step last page
  void stepLastPage() =>
      Provider.of<SearchFilmProvider>(context, listen: false).stepLastPage();

  // Onclick step first page
  void stepFirstPage() =>
      Provider.of<SearchFilmProvider>(context, listen: false).stepFirstPage();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: _buildBody(),
    );
  }

  Widget _buildTextNotify(String mes) {
    return Center(
      child: Text(
        mes,
        style: TextStyleConstant.labelMedium.copyWith(color: Colors.grey),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        if (_controller.text.isEmpty)
          Expanded(child: _buildTextNotify('Please input film\'s name !!')),
        if (_controller.text.isNotEmpty)
          Expanded(
            child: Consumer<SearchFilmProvider>(
              builder: (ctx, value, _) {
                return FutureBuilder(
                  future: Provider.of<SearchFilmProvider>(context).fetchApi(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CirculaProgressLoading();
                    }

                    // Check failured fetch api
                    String? error =
                        Provider.of<SearchFilmProvider>(context, listen: false)
                            .response!
                            .error;
                    if (error != null) {
                      return ErrorFetchApi(error);
                    }

                    final films =
                        Provider.of<SearchFilmProvider>(ctx, listen: false)
                            .response!
                            .films;

                    if (films.isNotEmpty) {
                      return GridFilm(films);
                    } else {
                      return _buildTextNotify(
                        'Not have result of "${_controller.text}"',
                      );
                    }
                  },
                );
              },
            ),
          ),
        if (_controller.text.isNotEmpty)
          PageBar(
            textPageCurrent: Consumer<SearchFilmProvider>(
              builder: (context, value, _) {
                return Text(
                  '${value.pageCurrent}',
                  style: TextStyleConstant.labelMedium,
                );
              },
            ),
            nextPage: nextPage,
            backPage: backPage,
            stepLastPage: stepLastPage,
            stepFirstPage: stepFirstPage,
          ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: kToolbarHeight,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Container(
        alignment: Alignment.center,
        child: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Search film\'s name...',
            hintStyle: TextStyleConstant.labelMedium,
            border: InputBorder.none,
          ),
          maxLines: 1,
          style: TextStyleConstant.labelMedium.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
          onSubmitted: (value) {
            setState(() {
              Provider.of<SearchFilmProvider>(context, listen: false).query =
                  value;
            });
          },
        ),
      ),
    );
  }
}

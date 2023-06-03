import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/models/film.dart';
import 'package:onfilm_app/providers/detail_film_provider.dart';
import 'package:onfilm_app/representations/screens/auth/auth_screen.dart';
import 'package:onfilm_app/representations/widgets/circular_progress_loading.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  final int id;
  final FilmType type;

  const FavoriteButton(
    this.id,
    this.type, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> onClickFavorite() async {
      Provider.of<DetailFilmProvider>(
        context,
        listen: false,
      ).isLoading = true;

      // If logined will add or del from firebase
      if (!Provider.of<DetailFilmProvider>(
        context,
        listen: false,
      ).isFavorited) {
        // If wasn't added in favorite will set data
        final Map<String, String> dataFilm = {
          'id': '$id',
          'type': type.name,
        };

        await Provider.of<DetailFilmProvider>(
          context,
          listen: false,
        ).setData(
            '$id',
            dataFilm,
            () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed in adding favorite!!'),
                  ),
                ));
      } else {
        // If was added in favorite will del data
        await Provider.of<DetailFilmProvider>(
          context,
          listen: false,
        ).delDoc(
            '$id',
            () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed in delete favorite!!'),
                  ),
                ));
      }

      Provider.of<DetailFilmProvider>(
        context,
        listen: false,
      ).isLoading = false;
    }

    return FutureBuilder(
        future: Provider.of<DetailFilmProvider>(
          context,
          listen: false,
        ).checkFavorited('$id'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(12),
              child: CirculaProgressLoading(),
            );
          }

          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Provider.of<DetailFilmProvider>(context).isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: CirculaProgressLoading(),
                      )
                    : IconButton(
                        onPressed: onClickFavorite,
                        iconSize: DimenssionConstant.kIconBtn,
                        icon: FaIcon(
                          Provider.of<DetailFilmProvider>(context).isFavorited
                              ? FontAwesomeIcons.solidHeart
                              : FontAwesomeIcons.heart,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      );
              }
              return IconButton(
                onPressed: () {
                  // If not login will show snackbar and go to auth screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('You need login!!'),
                    ),
                  );
                  Navigator.of(context).pushNamed(AuthScreen.nameRoute);
                },
                iconSize: DimenssionConstant.kIconBtn,
                icon: FaIcon(
                  FontAwesomeIcons.heart,
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            },
          );
        });
  }
}

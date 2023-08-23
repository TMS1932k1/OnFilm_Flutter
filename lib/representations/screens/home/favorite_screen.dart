import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onfilm_app/logic/providers/favorite_film_provider.dart';
import 'package:onfilm_app/representations/widgets/circular_progress_loading.dart';
import 'package:onfilm_app/representations/widgets/home/favorite_sort_bar.dart';
import 'package:onfilm_app/representations/widgets/home/grid_film.dart';
import 'package:onfilm_app/representations/widgets/home/notice_mes_text.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final topPanding = MediaQuery.of(context).padding.top;
          final uid = FirebaseAuth.instance.currentUser!.uid;

          return StreamBuilder(
            stream: FirebaseFirestore.instance.collection(uid).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const NoticeTextText(
                  'Not have film in favoirite',
                );
              }

              return Padding(
                padding: EdgeInsets.only(top: topPanding),
                child: Column(
                  children: [
                    const FavoriteSortBar(),
                    Expanded(
                      child: FutureBuilder(
                        future: Provider.of<FavoriteFilmProvider>(context)
                            .getDataFromFirebase(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CirculaProgressLoading();
                          }
                          final films = Provider.of<FavoriteFilmProvider>(
                            context,
                            listen: false,
                          ).films;
                          return GridFilm(films);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const NoticeTextText(
            'You need login to \nmark your favorite films',
          );
        }
      },
    );
  }
}

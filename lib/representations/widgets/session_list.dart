import 'package:flutter/material.dart';
import 'package:onfilm_app/models/film.dart';
import 'package:onfilm_app/representations/widgets/default_session_item.dart';
import 'package:onfilm_app/representations/widgets/home/top_session_item.dart';

enum SessionType {
  Default,
  Top,
}

class SessionList extends StatelessWidget {
  final List<Film> films;
  final SessionType sectionType;

  const SessionList(
    this.films,
    this.sectionType, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: films.length,
      itemBuilder: (ctx, index) {
        if (sectionType == SessionType.Default) {
          return DefaultSessionItem(
            films[index],
            films[index].filmType == FilmType.TVShow,
          );
        } else {
          return TopSessionItem(films[index], index + 1);
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:onfilm_app/models/film.dart';
import 'package:onfilm_app/representations/widgets/default_session_item.dart';
import 'package:onfilm_app/representations/widgets/home/top_session_horizontal_item.dart';
import 'package:onfilm_app/representations/widgets/home/top_session_vertical_item.dart';

enum SessionType {
  Default,
  Top,
}

class SessionVerticalList extends StatelessWidget {
  final List<Film> films;
  final SessionType sectionType;

  const SessionVerticalList(
    this.films,
    this.sectionType, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(top: 0),
      itemCount: films.length,
      itemBuilder: (ctx, index) {
        if (sectionType == SessionType.Default) {
          return DefaultSessionItem(
            films[index],
            films[index].filmType == FilmType.TVShow,
          );
        } else {
          return TopSessionVerticalItem(films[index], index + 1);
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';
import 'package:onfilm_app/logic/providers/favorite_film_provider.dart';
import 'package:provider/provider.dart';

class FavoriteSortBar extends StatelessWidget {
  const FavoriteSortBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Consumer<FavoriteFilmProvider>(
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
              isExpanded: false,
              style: TextStyleConstant.labelMedium,
              dropdownColor: Theme.of(context).colorScheme.background,
              elevation: 0,
            ),
          );
        },
      ),
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
}

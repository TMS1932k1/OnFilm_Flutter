import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';

class TitleSession extends StatelessWidget {
  final String title;

  const TitleSession(
    this.title, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: DimenssionConstant.kPandingLarge),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimenssionConstant.kPandingSmall,
          ),
          child: Row(
            children: [
              Container(
                height: 18,
                width: 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(
                width: DimenssionConstant.kPandingSmall,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: DimenssionConstant.kPandingSmall),
      ],
    );
  }
}

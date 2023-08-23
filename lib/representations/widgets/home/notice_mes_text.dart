import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';
import 'package:onfilm_app/representations/screens/auth/auth_screen.dart';

class NoticeTextText extends StatelessWidget {
  final String mes;
  const NoticeTextText(
    this.mes, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final topPanding = MediaQuery.of(context).padding.top;
    return Column(
      children: [
        SizedBox(
          height: topPanding,
        ),
        Expanded(
          child: Center(
            child: TextButton(
              onPressed: () {
                // Go to auth screen
                Navigator.of(context).pushNamed(AuthScreen.nameRoute);
              },
              child: Text(
                mes,
                style: TextStyleConstant.labelMedium.copyWith(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

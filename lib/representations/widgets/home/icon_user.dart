import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';

class IconUser extends StatelessWidget {
  final void Function() onClick;

  const IconUser(
    this.onClick, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final firstChar = FirebaseAuth.instance.currentUser!.email![0];
    return GestureDetector(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.all(DimenssionConstant.kPandingSmall),
        child: Container(
          width: kToolbarHeight - DimenssionConstant.kPandingSmall * 2,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.7),
            borderRadius: BorderRadius.circular(kToolbarHeight),
          ),
          child: Text(
            firstChar.toUpperCase(),
            style: TextStyleConstant.headlineSmall.copyWith(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

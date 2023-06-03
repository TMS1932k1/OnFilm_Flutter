import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';

class SiginOther extends StatelessWidget {
  final void Function()? signGoogle;

  const SiginOther({
    this.signGoogle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          IconButton(
            onPressed: signGoogle,
            icon: const FaIcon(
              FontAwesomeIcons.google,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

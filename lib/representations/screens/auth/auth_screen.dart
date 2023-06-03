import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/representations/widgets/auth/form_input.dart';

class AuthScreen extends StatelessWidget {
  static const nameRoute = '/auth';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          right: DimenssionConstant.kPandingSmall,
          left: DimenssionConstant.kPandingSmall,
          bottom: DimenssionConstant.kPandingSmall,
          top: DimenssionConstant.kPandingSmall + media.padding.top,
        ),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/auth_background.png',
              ),
              fit: BoxFit.cover,
              opacity: 0.1,
            ),
          ),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo_app.png',
                    height: 85,
                  ),
                  const SizedBox(
                    height: DimenssionConstant.kPandingLarge * 2,
                  ),
                  const FormInput(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

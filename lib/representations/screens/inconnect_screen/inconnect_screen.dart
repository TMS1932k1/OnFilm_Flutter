import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfilm_app/logic/blocs/internet_bloc.dart';
import 'package:onfilm_app/logic/blocs/internet_event.dart';
import 'package:onfilm_app/logic/blocs/internet_state.dart';
import 'package:onfilm_app/representations/screens/home/home_screen.dart';

class InconnectScreen extends StatefulWidget {
  const InconnectScreen({super.key});

  static const nameRoute = '/inconnect';

  @override
  State<InconnectScreen> createState() => _InconnectScreenState();
}

class _InconnectScreenState extends State<InconnectScreen> {
  Timer? _timer;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  void startTimer() {
    const duration = Duration(seconds: 1);
    _timer = Timer.periodic(duration, (timer) {
      getInternetStatus();
    });
  }

  Future<void> getInternetStatus() async {
    bool isConnectInternet;
    try {
      final bool result =
          await const MethodChannel('onfilm.flutter.dev/internet')
              .invokeMethod('getInternetStatus');
      isConnectInternet = result;
    } on PlatformException catch (_) {
      isConnectInternet = false;
    }

    if (context.mounted) {
      BlocProvider.of<InternetBloc>(context)
          .add(SetInternetEvent(isConnected: isConnectInternet));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetBloc, InternetState>(
      listener: (context, state) {
        if (state is ConnectedInternetState) {
          Navigator.popUntil(
            context,
            (route) => route.isFirst,
          );
          Navigator.of(context).pushReplacementNamed(HomeScreen.nameRoute);
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Text(
            'Please connect internet!!',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

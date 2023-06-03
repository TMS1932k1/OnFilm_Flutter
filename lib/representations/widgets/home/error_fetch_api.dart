import 'package:flutter/material.dart';

class ErrorFetchApi extends StatelessWidget {
  final String mesError;
  const ErrorFetchApi(
    this.mesError, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        mesError,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}

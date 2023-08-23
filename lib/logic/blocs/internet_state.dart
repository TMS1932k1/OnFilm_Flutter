import 'package:equatable/equatable.dart';

abstract class InternetState extends Equatable {
  const InternetState();
}

class ConnectedInternetState extends InternetState {
  const ConnectedInternetState();

  @override
  List<Object?> get props => [];
}

class InconnectedInternetState extends InternetState {
  const InconnectedInternetState();

  @override
  List<Object?> get props => [];
}

class LoadingInternetState extends InternetState {
  const LoadingInternetState();

  @override
  List<Object?> get props => [];
}

import 'package:equatable/equatable.dart';

abstract class InternetEvent extends Equatable {
  const InternetEvent();
}

class SetInternetEvent extends InternetEvent {
  final bool isConnected;

  const SetInternetEvent({required this.isConnected});

  @override
  List<Object?> get props => [];
}

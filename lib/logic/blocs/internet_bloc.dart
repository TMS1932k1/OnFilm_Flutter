import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfilm_app/logic/blocs/internet_event.dart';
import 'package:onfilm_app/logic/blocs/internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  InternetBloc() : super(const LoadingInternetState()) {
    on<SetInternetEvent>((event, emit) async {
      final isConnected = event.isConnected;
      emit(isConnected
          ? const ConnectedInternetState()
          : const InconnectedInternetState());
    });
  }
}

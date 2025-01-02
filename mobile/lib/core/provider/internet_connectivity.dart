import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectivityStatus { notDetermined, isConnected, isDisconnected }

final connectivityStatusProvider =
    StateNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatus>(
  (ref) => ConnectivityStatusNotifier(ConnectivityStatus.isDisconnected),
);

class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {
  late ConnectivityStatus lastResult;
  late ConnectivityStatus newState;
  ConnectivityStatusNotifier(ConnectivityStatus initialState)
      : super(initialState) {
    lastResult = initialState;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        newState = ConnectivityStatus.isConnected;
      } else {
        newState = ConnectivityStatus.isDisconnected;
      }
      if (newState != lastResult) {
        state = newState;
        lastResult = newState;
      }
    });
  }

  // Method to set the state explicitly for testing purposes
  void setStateForTesting(ConnectivityStatus newState) {
    state = newState;
  }
  // ConnectivityStatusNotifier() : super(ConnectivityStatus.isConnected) {
  //   lastResult = state;

  //   Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
  //     if (result == ConnectivityResult.mobile ||
  //         result == ConnectivityResult.wifi) {
  //       newState = ConnectivityStatus.isConnected;
  //     } else {
  //       newState = ConnectivityStatus.isDisconnected;
  //     }
  //     if (newState != lastResult) {
  //       state = newState;
  //       lastResult = newState;
  //     }
  //   });
  // }
}

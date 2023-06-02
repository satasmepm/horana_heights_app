import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkManager {
  static NetworkManager? _instance;
  static ConnectivityResult? _connectivityResult;

  factory NetworkManager() {
    _instance ??= NetworkManager._();
    return _instance!;
  }

  NetworkManager._();

  Future<void> initConnectivity(Connectivity connectivity) async {
    final ConnectivityResult result = await connectivity.checkConnectivity();
    _connectivityResult = result;

    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectivityResult = result;
    });
  }

  bool get isConnected => _connectivityResult != ConnectivityResult.none;
}

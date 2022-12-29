import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> startCheckConnect();
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected => startCheckConnect();

  @override
  Future<bool> startCheckConnect() async {
    bool isConnected = false;

    var connectivityResult = await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile) {
      isConnected = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isConnected = true;
    }
    return isConnected;
  }
}

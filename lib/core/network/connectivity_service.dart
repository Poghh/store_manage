import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity;

  ConnectivityService(this._connectivity);

  Stream<ConnectivityResult> get onChanged => _connectivity.onConnectivityChanged.map(
    (results) => results.contains(ConnectivityResult.none)
        ? ConnectivityResult.none
        : (results.isNotEmpty ? results.first : ConnectivityResult.none),
  );

  Future<bool> get isOnline async {
    final results = await _connectivity.checkConnectivity();
    if (results.isEmpty) return false;
    return !results.contains(ConnectivityResult.none);
  }
}

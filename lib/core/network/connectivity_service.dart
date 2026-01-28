import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityService {
  final InternetConnection _connection;

  ConnectivityService(this._connection);

  Stream<InternetStatus> get onChanged => _connection.onStatusChange;

  Future<bool> get isOnline => _connection.hasInternetAccess;
}

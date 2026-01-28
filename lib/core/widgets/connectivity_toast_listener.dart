import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/network/connectivity_service.dart';
import 'package:store_manage/core/utils/app_toast.dart';

class ConnectivityToastListener extends StatefulWidget {
  final Widget child;

  const ConnectivityToastListener({super.key, required this.child});

  @override
  State<ConnectivityToastListener> createState() => _ConnectivityToastListenerState();
}

class _ConnectivityToastListenerState extends State<ConnectivityToastListener> {
  late final ConnectivityService _connectivity;
  StreamSubscription<InternetStatus>? _subscription;
  bool? _isOnline;
  bool _initialized = false;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _connectivity = di<ConnectivityService>();
    _bootstrap();
    // Delay subscription until after first frame to ensure Navigator is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isReady = true;
      _subscription = _connectivity.onChanged.listen(_handleChange);
    });
  }

  Future<void> _bootstrap() async {
    final online = await _connectivity.isOnline;
    _isOnline = online;
    _initialized = true;
  }

  void _handleChange(InternetStatus status) {
    final online = status == InternetStatus.connected;
    if (!_initialized || !_isReady) {
      _isOnline = online;
      _initialized = true;
      return;
    }
    if (_isOnline == online) return;
    _isOnline = online;
    if (!mounted) return;
    if (online) {
      AppToast.success(context, AppStrings.connectivityOnline);
    } else {
      AppToast.warning(context, AppStrings.connectivityOffline);
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

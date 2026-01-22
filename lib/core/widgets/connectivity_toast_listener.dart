import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

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
  StreamSubscription<ConnectivityResult>? _subscription;
  bool? _isOnline;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _connectivity = di<ConnectivityService>();
    _bootstrap();
    _subscription = _connectivity.onChanged.listen(_handleChange);
  }

  Future<void> _bootstrap() async {
    final online = await _connectivity.isOnline;
    _isOnline = online;
    _initialized = true;
  }

  void _handleChange(ConnectivityResult result) {
    final online = result != ConnectivityResult.none;
    if (!_initialized) {
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

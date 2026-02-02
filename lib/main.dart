import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/data/database/app_database.dart';
import 'package:store_manage/core/data/database/daos/app_state_dao.dart';
import 'package:store_manage/core/data/sync/daily_sync_service.dart';
import 'package:store_manage/core/navigation/app_router.dart';
import 'package:store_manage/core/navigation/route_observer.dart';
import 'package:store_manage/core/data/storage/secure_storage.dart';
import 'package:store_manage/core/theme/app_theme.dart';
import 'package:store_manage/core/widgets/splash_screen.dart';
import 'package:toastification/toastification.dart';
import 'package:store_manage/core/widgets/connectivity_toast_listener.dart';

final _appRouter = AppRouter();

Future mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await setupDI();
  await _handleFreshInstall();
  runApp(MyApp());
}

/// iOS Keychain persists data even after app uninstall.
/// Use Drift database to detect fresh install and clear keychain if needed.
Future<void> _handleFreshInstall() async {
  const installedKey = 'has_been_installed';

  final database = di<AppDatabase>();
  final appStateDao = AppStateDao(database);

  final hasBeenInstalled = await appStateDao.hasKey(installedKey);

  if (!hasBeenInstalled) {
    // Fresh install - clear keychain data that may persist from previous install
    await di<SecureStorageImpl>().removeAllAsync();
    await appStateDao.setValue(installedKey, 'true');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool _showSplash = true;
  String? _savedPhone;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeApp();
    _triggerDailySync();
  }

  Future<void> _initializeApp() async {
    final secureStorage = di<SecureStorageImpl>();
    _savedPhone = await secureStorage.getSavedPhoneNumber();

    if (mounted) {
      setState(() => _isInitialized = true);
    }

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _showSplash = false);
    }
  }

  Future<void> _triggerDailySync() async {
    try {
      final secureStorage = di<SecureStorageImpl>();
      final hasToken = await secureStorage.hasToken();
      final userId = await secureStorage.getUserId();
      if (!hasToken || userId == null || userId.trim().isEmpty) return;
      await di<DailySyncService>().syncPending();
    } catch (_) {}
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _triggerDailySync();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
    }

    return ToastificationWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.defaultTheme,
        themeMode: ThemeMode.system,
        routerConfig: _appRouter.config(
          navigatorObservers: () => [MyRouteObserver()],
          deepLinkBuilder: (_) {
            if (_savedPhone != null) {
              return DeepLink([PinInputRoute(phoneNumber: _savedPhone!)]);
            }
            return DeepLink([const PhoneInputRoute()]);
          },
        ),
        builder: (context, child) {
          return ConnectivityToastListener(
            child: Stack(
              children: [
                child ?? const SizedBox(),
                IgnorePointer(
                  ignoring: !_showSplash,
                  child: AnimatedOpacity(
                    opacity: _showSplash ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                    child: const SplashScreen(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

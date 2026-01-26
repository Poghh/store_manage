import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/navigation/app_router.dart';
import 'package:store_manage/core/navigation/route_observer.dart';
import 'package:store_manage/core/storage/secure_storage.dart';
import 'package:store_manage/core/theme/app_theme.dart';
import 'package:store_manage/core/widgets/splash_screen.dart';
import 'package:toastification/toastification.dart';
import 'package:store_manage/core/widgets/connectivity_toast_listener.dart';

final _appRouter = AppRouter();

Future mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  await setupDI();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showSplash = true;
  String? _savedPhone;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
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

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
    }

    return MaterialApp.router(
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
        return ToastificationWrapper(
          child: ConnectivityToastListener(
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
          ),
        );
      },
    );
  }
}

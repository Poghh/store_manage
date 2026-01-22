import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/navigation/app_router.dart';
import 'package:store_manage/core/navigation/route_observer.dart';
import 'package:store_manage/core/theme/app_theme.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(navigatorObservers: () => [MyRouteObserver()]),
      builder: (context, child) =>
          ToastificationWrapper(child: ConnectivityToastListener(child: child ?? const SizedBox.shrink())),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultTheme,
      // darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}

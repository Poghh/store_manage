import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:store_manage/feature/home/presentation/page/home_page.dart';
import 'package:store_manage/feature/home/presentation/page/home_tabs_page.dart';
import 'package:store_manage/feature/authentication/presentation/page/forgot_pin_page.dart';
import 'package:store_manage/feature/authentication/presentation/page/phone_input_page.dart';
import 'package:store_manage/feature/authentication/presentation/page/pin_input_page.dart';
import 'package:store_manage/feature/authentication/presentation/page/verify_phone_page.dart';
import 'package:store_manage/feature/money_transaction/presentation/page/money_transaction_page.dart';
import 'package:store_manage/feature/product/presentation/page/product_details_page.dart';
import 'package:store_manage/feature/retail/presentation/page/retail_page.dart';
import 'package:store_manage/feature/stock_in/presentation/page/stock_in_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: PhoneInputRoute.page, path: '/', initial: true),
    AutoRoute(page: PinInputRoute.page, path: '/pin-input'),
    AutoRoute(page: ForgotPinRoute.page, path: '/forgot-pin'),
    AutoRoute(page: VerifyPhoneRoute.page, path: '/verify-phone'),
    AutoRoute(page: HomeTabsRoute.page, path: '/home-tabs'),
    AutoRoute(page: HomeRoute.page, path: '/home'),
    AutoRoute(page: StockInRoute.page, path: '/stock-in'),
    AutoRoute(page: ProductDetailsRoute.page, path: '/product-details'),
    AutoRoute(page: RetailRoute.page, path: '/retail'),
    AutoRoute(page: MoneyTransactionRoute.page, path: '/money-transaction'),
  ];
}

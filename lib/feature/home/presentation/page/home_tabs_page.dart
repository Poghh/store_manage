import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/data/sync/daily_sync_service.dart';
import 'package:store_manage/core/navigation/home_tab_coordinator.dart';
import 'package:store_manage/feature/home/presentation/page/home_page.dart';
import 'package:store_manage/feature/profile/presentation/page/profile_page.dart';
import 'package:store_manage/feature/product/presentation/page/inventory_page.dart';
import 'package:store_manage/feature/reports/presentation/page/reports_page.dart';
import 'package:store_manage/feature/transactions/presentation/page/transactions_page.dart';

@RoutePage()
class HomeTabsPage extends StatefulWidget {
  const HomeTabsPage({super.key});

  @override
  State<HomeTabsPage> createState() => _HomeTabsPageState();
}

class _HomeTabsPageState extends State<HomeTabsPage> {
  late final PersistentTabController _controller;
  late final HomeTabCoordinator _tabCoordinator;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
    _tabCoordinator = di<HomeTabCoordinator>();
    _tabCoordinator.requestedIndex.addListener(_handleTabRequest);
    di<DailySyncService>().startListening();
  }

  @override
  void dispose() {
    _tabCoordinator.requestedIndex.removeListener(_handleTabRequest);
    _controller.dispose();
    super.dispose();
  }

  void _handleTabRequest() {
    final target = _tabCoordinator.requestedIndex.value;
    if (target == null) return;
    _controller.index = target;
    _tabCoordinator.requestedIndex.value = null;
  }

  List<Widget> _buildScreens() {
    return const [HomePage(), TransactionsPage(), InventoryPage(), ReportsPage(), ProfilePage()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    const textStyle = TextStyle(
      fontSize: AppFontSizes.fontSize12,
      fontWeight: FontWeight.w600,
      fontFamily: AppFonts.inter,
    );

    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_outlined),
        title: AppStrings.homeTabHome,
        textStyle: textStyle,
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.textMuted,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.receipt_long_outlined),
        title: AppStrings.homeTabTransactions,
        textStyle: textStyle,
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.textMuted,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.inventory_2_outlined),
        title: AppStrings.homeTabInventory,
        textStyle: textStyle,
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.textMuted,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.bar_chart_outlined),
        title: AppStrings.homeTabReports,
        textStyle: textStyle,
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.textMuted,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_outline),
        title: AppStrings.homeTabProfile,
        textStyle: textStyle,
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.textMuted,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      onItemSelected: (index) {
        if (index == 1) {
          _tabCoordinator.selectedTransactionDate.value = DateTime.now();
        }
      },
      confineToSafeArea: true,
      navBarHeight: AppNumbers.DOUBLE_70,
      backgroundColor: AppColors.surface,
      decoration: const NavBarDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      navBarStyle: NavBarStyle.style9,
    );
  }
}

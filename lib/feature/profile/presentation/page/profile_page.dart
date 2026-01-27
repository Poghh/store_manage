import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/navigation/app_router.dart';
import 'package:store_manage/core/storage/secure_storage.dart';
import 'package:store_manage/core/utils/app_dialog.dart';
import 'package:store_manage/core/widgets/app_page_header.dart';
import 'package:store_manage/feature/profile/presentation/widgets/profile_header_card.dart';
import 'package:store_manage/feature/profile/presentation/widgets/profile_logout_card.dart';
import 'package:store_manage/feature/profile/presentation/widgets/profile_section_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppPageHeader(title: AppStrings.homeTabProfile),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
          children: [
            const ProfileHeaderCard(name: AppStrings.profileName, email: AppStrings.profileEmail),
            const SizedBox(height: AppNumbers.DOUBLE_16),
            ProfileSectionCard(
              title: AppStrings.profileSectionAccount,
              items: const [
                ProfileItem(label: AppStrings.profileItemPersonalInfo, icon: Icons.badge_outlined),
                ProfileItem(label: AppStrings.profileItemChangePassword, icon: Icons.lock_outline),
              ],
            ),
            const SizedBox(height: AppNumbers.DOUBLE_16),
            ProfileSectionCard(
              title: AppStrings.profileSectionSettings,
              items: const [
                ProfileItem(label: AppStrings.profileItemNotifications, icon: Icons.notifications_outlined),
                ProfileItem(label: AppStrings.profileItemLanguage, icon: Icons.language_outlined),
                ProfileItem(label: AppStrings.profileItemTheme, icon: Icons.dark_mode_outlined),
              ],
            ),
            const SizedBox(height: AppNumbers.DOUBLE_16),
            ProfileSectionCard(
              title: AppStrings.profileSectionSupport,
              items: const [
                ProfileItem(label: AppStrings.profileItemHelpCenter, icon: Icons.help_outline),
                ProfileItem(label: AppStrings.profileItemContactSupport, icon: Icons.headset_mic_outlined),
              ],
            ),
            const SizedBox(height: AppNumbers.DOUBLE_16),
            ProfileLogoutCard(onTap: () => _handleLogout(context)),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final confirmed = await AppDialog.confirmAsync(
      context: context,
      title: AppStrings.logoutTitle,
      message: AppStrings.logoutMessage,
      confirmText: AppStrings.logoutConfirm,
      cancelText: AppStrings.logoutCancel,
    );

    if (confirmed && context.mounted) {
      await di<SecureStorageImpl>().removeAllAsync();
      if (context.mounted) {
        context.router.replaceAll([const PhoneInputRoute()]);
      }
    }
  }
}

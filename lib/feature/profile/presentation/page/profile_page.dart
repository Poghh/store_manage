import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/navigation/app_router.dart';
import 'package:store_manage/core/data/storage/secure_storage.dart';
import 'package:store_manage/core/utils/app_dialog.dart';
import 'package:store_manage/core/widgets/app_page_header.dart';
import 'package:store_manage/feature/profile/presentation/widgets/profile_header_card.dart';
import 'package:store_manage/feature/profile/presentation/widgets/profile_logout_card.dart';
import 'package:store_manage/feature/profile/presentation/widgets/profile_section_card.dart';
import 'package:store_manage/feature/profile/presentation/page/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userName = '';
  String _storeName = '';
  String? _avatarPath;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final storage = di<SecureStorageImpl>();
    final userName = await storage.getUserName();
    final storeName = await storage.getStoreName();
    final avatarPath = await storage.getAvatarPath();
    if (mounted) {
      setState(() {
        _userName = userName ?? AppStrings.profileName;
        _storeName = storeName ?? '';
        _avatarPath = avatarPath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppPageHeader(title: AppStrings.homeTabProfile),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppNumbers.DOUBLE_16),
          children: [
            ProfileHeaderCard(name: _userName, email: _storeName, avatarPath: _avatarPath),
            const SizedBox(height: AppNumbers.DOUBLE_16),
            ProfileSectionCard(
              title: AppStrings.profileSectionAccount,
              items: const [
                ProfileItem(label: AppStrings.profileItemPersonalInfo, icon: Icons.badge_outlined),
                ProfileItem(label: AppStrings.profileItemChangePassword, icon: Icons.lock_outline),
              ],
              onItemTap: (item) async {
                if (item.label == AppStrings.profileItemChangePassword) {
                  context.router.push(const VerifyCurrentPinRoute());
                } else if (item.label == AppStrings.profileItemPersonalInfo) {
                  final result = await Navigator.of(context).push<bool>(
                    MaterialPageRoute(
                      builder: (_) => EditProfilePage(
                        initialName: _userName,
                        initialStoreName: _storeName,
                        initialAvatarPath: _avatarPath,
                      ),
                    ),
                  );
                  if (result == true) {
                    _loadUserData();
                  }
                }
              },
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
      type: AppDialogType.error,
    );

    if (confirmed && context.mounted) {
      await di<SecureStorageImpl>().removeAllAsync();
      if (context.mounted) {
        context.router.replaceAll([const PhoneInputRoute()]);
      }
    }
  }
}

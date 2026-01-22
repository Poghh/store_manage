import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/utils/app_toast.dart';

class AppImagePicker {
  const AppImagePicker._();

  static Future<String?> pickImage(BuildContext context) async {
    if (Platform.isIOS) {
      final permission = await PhotoManager.requestPermissionExtend();
      if (!permission.isAuth) {
        if (!context.mounted) return null;
        AppToast.error(context, AppStrings.photoPermissionDenied);
        return null;
      }

      if (!context.mounted) return null;
      final assets = await AssetPicker.pickAssets(
        context,
        pickerConfig: const AssetPickerConfig(maxAssets: 1, requestType: RequestType.image),
      );
      if (assets == null || assets.isEmpty) return null;
      final file = await assets.first.file;
      return file?.path;
    }

    final picked = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 85);
    return picked?.path;
  }
}

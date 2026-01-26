import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/utils/app_toast.dart';

class AppImagePicker {
  const AppImagePicker._();

  /// Pick a single image from gallery
  ///
  /// Respects iOS Limited Access - only shows photos user has granted access to.
  /// On iOS 14+, if user has limited access, only selected photos will be shown.
  ///
  /// Returns the file path of the selected image, or null if cancelled.
  static Future<String?> pickImage(BuildContext context) async {
    // Request permission
    final permission = await PhotoManager.requestPermissionExtend();

    if (permission == PermissionState.denied ||
        permission == PermissionState.restricted) {
      if (!context.mounted) return null;
      AppToast.error(context, AppStrings.photoPermissionDenied);
      return null;
    }

    // Get all photos that app has access to (respects limited access)
    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true, // Only get "Recent" album
    );

    if (albums.isEmpty) {
      if (!context.mounted) return null;
      AppToast.error(context, 'Không có ảnh nào khả dụng');
      return null;
    }

    // Get photos from the first album (Recent)
    final List<AssetEntity> photos = await albums.first.getAssetListPaged(
      page: 0,
      size: 100, // Get first 100 photos
    );

    if (photos.isEmpty) {
      if (!context.mounted) return null;
      AppToast.error(context, 'Không có ảnh nào khả dụng');
      return null;
    }

    if (!context.mounted) return null;

    // Show custom picker with only accessible photos
    final selected = await showModalBottomSheet<AssetEntity>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ImagePickerSheet(
        photos: photos,
        isLimitedAccess: permission == PermissionState.limited,
      ),
    );

    if (selected == null) return null;

    // Get file from selected asset
    final file = await selected.file;
    return file?.path;
  }
}

class _ImagePickerSheet extends StatelessWidget {
  final List<AssetEntity> photos;
  final bool isLimitedAccess;

  const _ImagePickerSheet({
    required this.photos,
    required this.isLimitedAccess,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  'Chọn ảnh',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (isLimitedAccess)
                  TextButton.icon(
                    onPressed: () async {
                      try {
                        await PhotoManager.presentLimited();
                      } catch (e) {
                        debugPrint('presentLimited error: $e');
                      }
                    },
                    icon: const Icon(Icons.add_photo_alternate, size: 18),
                    label: const Text('Thêm ảnh'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                    ),
                  ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Photo grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                final photo = photos[index];
                return GestureDetector(
                  onTap: () => Navigator.pop(context, photo),
                  child: _PhotoThumbnail(asset: photo),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotoThumbnail extends StatelessWidget {
  final AssetEntity asset;

  const _PhotoThumbnail({required this.asset});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: asset.thumbnailDataWithSize(
        const ThumbnailSize(200, 200),
        quality: 80,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.memory(
              snapshot.data!,
              fit: BoxFit.cover,
            ),
          );
        }
        return Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceMuted,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
    );
  }
}

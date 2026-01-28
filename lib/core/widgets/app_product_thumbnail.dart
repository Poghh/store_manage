import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/network/connectivity_service.dart';

class AppProductThumbnail extends StatefulWidget {
  final String? imageUrl;
  final double size;
  final double borderRadius;
  final double padding;
  final IconData placeholderIcon;
  final Color placeholderColor;
  final double placeholderSize;
  final Color backgroundColor;
  final BoxFit fit;

  const AppProductThumbnail({
    super.key,
    required this.imageUrl,
    required this.size,
    this.borderRadius = AppNumbers.DOUBLE_12,
    this.padding = AppNumbers.DOUBLE_6,
    this.placeholderIcon = Icons.inventory_2_outlined,
    this.placeholderColor = AppColors.primary,
    this.placeholderSize = AppNumbers.DOUBLE_28,
    this.backgroundColor = AppColors.background,
    this.fit = BoxFit.contain,
  });

  @override
  State<AppProductThumbnail> createState() => _AppProductThumbnailState();
}

class _AppProductThumbnailState extends State<AppProductThumbnail> {
  late final ConnectivityService _connectivity;
  late final Stream<InternetStatus> _connectivityStream;
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    _connectivity = di<ConnectivityService>();
    _connectivityStream = _connectivity.onChanged;
    _connectivity.isOnline.then((online) {
      if (!mounted) return;
      setState(() => _isOffline = !online);
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = widget.imageUrl != null && widget.imageUrl!.isNotEmpty;
    final imageSource = widget.imageUrl ?? '';
    final isNetwork = _isNetworkUrl(imageSource);
    final isAsset = _isAssetPath(imageSource);
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Container(
        width: widget.size,
        height: widget.size,
        color: widget.backgroundColor,
        padding: EdgeInsets.all(widget.padding),
        child: hasImage
            ? _buildImage(imageSource, isNetwork: isNetwork, isAsset: isAsset)
            : Icon(widget.placeholderIcon, color: widget.placeholderColor, size: widget.placeholderSize),
      ),
    );
  }

  Widget _buildImage(String source, {required bool isNetwork, required bool isAsset}) {
    if (isNetwork) {
      return StreamBuilder<InternetStatus>(
        stream: _connectivityStream,
        initialData: _isOffline ? InternetStatus.disconnected : InternetStatus.connected,
        builder: (context, snapshot) {
          final status = snapshot.data ?? InternetStatus.disconnected;
          final isOffline = status == InternetStatus.disconnected;
          if (isOffline) {
            return Icon(widget.placeholderIcon, color: widget.placeholderColor, size: widget.placeholderSize);
          }
          return CachedNetworkImage(
            imageUrl: source,
            fit: widget.fit,
            placeholder: (context, url) => Icon(
              widget.placeholderIcon,
              color: widget.placeholderColor.withValues(alpha: 0.5),
              size: widget.placeholderSize,
            ),
            errorWidget: (context, url, error) =>
                Icon(widget.placeholderIcon, color: widget.placeholderColor, size: widget.placeholderSize),
          );
        },
      );
    }

    if (isAsset) {
      return Image.asset(source, fit: widget.fit);
    }

    if (kIsWeb) {
      return Icon(widget.placeholderIcon, color: widget.placeholderColor, size: widget.placeholderSize);
    }

    final normalized = _normalizeLocalPath(source);
    return Image.file(
      File(normalized),
      fit: widget.fit,
      errorBuilder: (context, error, stackTrace) =>
          Icon(widget.placeholderIcon, color: widget.placeholderColor, size: widget.placeholderSize),
    );
  }

  bool _isNetworkUrl(String value) => value.startsWith('http://') || value.startsWith('https://');

  bool _isAssetPath(String value) => value.startsWith('assets/');

  String _normalizeLocalPath(String value) {
    final uri = Uri.tryParse(value);
    if (uri != null && uri.scheme == 'file') {
      return uri.toFilePath();
    }
    return value;
  }
}

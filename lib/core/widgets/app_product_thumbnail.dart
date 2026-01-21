import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

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
  late final Stream<List<ConnectivityResult>> _connectivityStream;
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    _connectivityStream = Connectivity().onConnectivityChanged;
    Connectivity().checkConnectivity().then((result) {
      if (!mounted) return;
      setState(() => _isOffline = result.contains(ConnectivityResult.none));
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = widget.imageUrl != null && widget.imageUrl!.isNotEmpty;
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Container(
        width: widget.size,
        height: widget.size,
        color: widget.backgroundColor,
        padding: EdgeInsets.all(widget.padding),
        child: hasImage
            ? StreamBuilder<List<ConnectivityResult>>(
                stream: _connectivityStream,
                initialData: _isOffline ? const [ConnectivityResult.none] : const [ConnectivityResult.wifi],
                builder: (context, snapshot) {
                  final results = snapshot.data ?? const <ConnectivityResult>[];
                  final isOffline = results.contains(ConnectivityResult.none);
                  if (isOffline) {
                    return Icon(widget.placeholderIcon, color: widget.placeholderColor, size: widget.placeholderSize);
                  }
                  return CachedNetworkImage(
                    imageUrl: widget.imageUrl!,
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
              )
            : Icon(widget.placeholderIcon, color: widget.placeholderColor, size: widget.placeholderSize),
      ),
    );
  }
}

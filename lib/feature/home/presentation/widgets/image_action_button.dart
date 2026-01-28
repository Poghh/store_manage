import 'package:flutter/material.dart';
import 'package:store_manage/core/constants/app_numbers.dart';

class ImageActionButton extends StatefulWidget {
  final VoidCallback onTap;
  final String backgroundImage;

  final String title;
  final String subtitle;

  final IconData leadingIcon;
  final Color leadingIconColor;

  final Color titleColor;
  final Color subtitleColor;

  final Color arrowBackgroundColor;
  final Color arrowIconColor;

  const ImageActionButton({
    super.key,
    required this.onTap,
    required this.backgroundImage,
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
    required this.leadingIconColor,
    required this.titleColor,
    required this.subtitleColor,
    required this.arrowBackgroundColor,
    required this.arrowIconColor,
  });

  @override
  State<ImageActionButton> createState() => _ImageActionButtonState();
}

class _ImageActionButtonState extends State<ImageActionButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedOpacity(
          opacity: _pressed ? 0.92 : 1.0,
          duration: const Duration(milliseconds: 120),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_16),
            child: Stack(
              children: [
                Image.asset(widget.backgroundImage, fit: BoxFit.cover, width: double.infinity),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppNumbers.DOUBLE_24,
                      vertical: AppNumbers.DOUBLE_16,
                    ),
                    child: Row(
                      children: [
                        Icon(widget.leadingIcon, size: AppNumbers.DOUBLE_48, color: widget.leadingIconColor),
                        const SizedBox(width: AppNumbers.DOUBLE_12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.title,
                                  style: textTheme.displaySmall?.copyWith(color: widget.titleColor),
                                ),
                              ),
                              const SizedBox(height: AppNumbers.DOUBLE_4),
                              Text(
                                widget.subtitle,
                                style: textTheme.labelLarge?.copyWith(color: widget.subtitleColor),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: AppNumbers.DOUBLE_32,
                          width: AppNumbers.DOUBLE_32,
                          decoration: BoxDecoration(
                            color: widget.arrowBackgroundColor,
                            borderRadius: BorderRadius.circular(AppNumbers.DOUBLE_8),
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: AppNumbers.DOUBLE_14,
                            color: widget.arrowIconColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

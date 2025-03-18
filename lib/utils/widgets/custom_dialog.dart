import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otk_employee/utils/theme/app_colors.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({
    this.title,
    this.titleStyle,
    this.child,
    this.width,
    this.maxHeight,
    super.key,
  });

  final String? title;
  final TextStyle? titleStyle;
  final Widget? child;
  final double? width;
  final double? maxHeight;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  String get title => widget.title ?? "No Title";
  Widget? get child => widget.child;
  double? get width => widget.width;
  double? get maxHeight => widget.maxHeight;
  TextStyle? get titleStyle => widget.titleStyle;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, snapshot) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Get.back(result: false);
            },
            style: IconButton.styleFrom(
              backgroundColor: AppColors.light,
              foregroundColor: AppColors.primary,
            ),
            icon: const Icon(Icons.close),
            tooltip: "Oynani yopish",
          ),
          Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: width ?? Get.width * 0.8,
              constraints: BoxConstraints(
                maxHeight: maxHeight ?? Get.height * 0.8,
              ),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: titleStyle ??
                            const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  child ?? const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

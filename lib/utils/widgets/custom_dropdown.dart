import 'package:flutter/material.dart';
import 'package:otk_employee/utils/theme/app_colors.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    this.hint,
    this.tooltip,
    this.items,
    this.disabledItems,
    this.onChanged,
    this.value,
    this.size,
    this.color,
    super.key,
  });

  final String? hint;
  final String? tooltip;
  final List<DropdownMenuItem>? items;
  final List? disabledItems;
  final dynamic value;
  final void Function(dynamic)? onChanged;
  final double? size;
  final Color? color;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  // dynamic value;

  double? get size => widget.size;
  Color? get color => widget.color;
  String? get hint => widget.hint;
  List<DropdownMenuItem>? get items => widget.items;
  void Function(dynamic)? get onChanged => widget.onChanged;

  @override
  void initState() {
    // value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip ?? "",
      child: Container(
        height: size ?? 50,
        decoration: BoxDecoration(
          color: color ?? AppColors.secondary.withValues(alpha: 0.8),
          // borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              menuMaxHeight: 300,
              isExpanded: true,
              items: items,
              onChanged: (valuee) {
                onChanged?.call(valuee);
              },
              value: widget.value,
              hint: Text(
                hint ?? "",
                style: const TextStyle(
                  color: Colors.grey,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

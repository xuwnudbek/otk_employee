import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otk_employee/utils/theme/app_colors.dart';

class CustomInput extends StatefulWidget {
  const CustomInput({
    this.controller,
    this.hint,
    this.formatters,
    this.onChanged,
    this.size,
    this.padding,
    this.color,
    this.lines,
    this.trailing,
    this.focusNode,
    this.keybordType,
    this.cursorAnimation,
    super.key,
  });

  final String? hint;
  final TextEditingController? controller;
  final List<TextInputFormatter>? formatters;
  final void Function(dynamic)? onChanged;
  final double? size;
  final int? lines;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Widget? trailing;
  final FocusNode? focusNode;
  final TextInputType? keybordType;
  final bool? cursorAnimation;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size ?? 50,
      decoration: BoxDecoration(
        color: widget.color ?? AppColors.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: widget.padding ?? const EdgeInsets.only(left: 16, right: 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                keyboardType: widget.keybordType,
                inputFormatters: widget.formatters ?? [],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: widget.hint,
                  hintStyle: TextStyle(
                    color: AppColors.dark.withValues(alpha: 0.5),
                  ),
                ),
                maxLines: widget.lines,
                cursorHeight: 20,
                onChanged: widget.onChanged,
              ),
            ),
            if (widget.trailing != null) widget.trailing!,
          ],
        ),
      ),
    );
  }
}

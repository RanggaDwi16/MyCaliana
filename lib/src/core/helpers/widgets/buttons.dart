import 'package:flutter/material.dart';
import 'package:my_caliana/src/core/utils/constant/app_colors.dart';

enum ButtonStyle { filled, outlined }

class Button extends StatelessWidget {
  const Button.filled({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.style = ButtonStyle.filled,
    this.color = AppColor.primaryColor,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 48.0,
    this.borderColor = AppColor.primaryColor,
    this.borderRadius = 25,
    this.disabled = false,
    this.isActive = false,
    this.fontSize = 15.0,
    this.elevation = 0.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
  });

  const Button.outlined({
    super.key,
    required this.onPressed,
    this.label = "",
    this.icon,
    this.style = ButtonStyle.outlined,
    this.color = Colors.transparent,
    this.textColor = AppColor.primaryColor,
    this.width = double.infinity,
    this.height = 48.0,
    this.borderRadius = 25,
    this.borderColor = AppColor.primaryColor,
    this.disabled = false,
    this.isActive = false,
    this.fontSize = 14.0,
    this.elevation = 0.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
  });

  final Function() onPressed;
  final String label;
  final Widget? icon;
  final ButtonStyle style;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final double width;
  final double height;
  final double borderRadius;
  final bool disabled;
  final bool isActive;
  final double fontSize;
  final double elevation;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: style == ButtonStyle.filled
          ? ElevatedButton(
              onPressed: disabled ? null : onPressed,
              style: ElevatedButton.styleFrom(
                padding: padding,
                elevation: elevation,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ).copyWith(
                backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.disabled)) {
                      return AppColor.disabledColor;
                    }
                    return color;
                  },
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) icon!,
                  if (icon != null) const SizedBox(width: 10.0),
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'Helvetica Neue',
                      color: disabled ? AppColor.textDisabledColor : textColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                padding: padding,
                elevation: elevation,
                foregroundColor: textColor,
                side: BorderSide(color: borderColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: Center(
                child: icon ??
                    Text(
                      label,
                      style: TextStyle(
                        fontFamily: 'Helvetica Neue',
                        color:
                            disabled ? AppColor.textDisabledColor : textColor,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              ),
            ),
    );
  }
}

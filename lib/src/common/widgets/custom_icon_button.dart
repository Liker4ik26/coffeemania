import 'package:coffee_mania/src/common/widgets/svg_icon.dart';
import 'package:coffee_mania/src/config/styles/dimensions.dart';
import 'package:coffee_mania/src/extensions/context_extensions.dart';
import 'package:coffee_mania/src/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key, required this.icon, this.onPressed});

  final String icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        backgroundColor:
            WidgetStatePropertyAll(context.colorsExt.backgroundSecondaryColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            side: BorderSide(
              color: context.colorsExt.primaryColor.withOpacity(.2),
            ),
            borderRadius: BorderRadius.circular(AppDimensions.small),
          ),
        ),
        elevation: const WidgetStatePropertyAll(20),
      ),
      onPressed: onPressed,
      icon: SvgIcon(
        height: 16,
        width: 16,
        icon: icon,
        color: context.colorsExt.primaryColor,
      ).paddingAll(8),
    );
  }
}

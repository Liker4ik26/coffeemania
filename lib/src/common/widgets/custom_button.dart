import 'package:coffee_mania/src/config/styles/dimensions.dart';
import 'package:coffee_mania/src/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.all(16)),
        backgroundColor: WidgetStatePropertyAll(context.colorsExt.accentColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.medium),
          ),
        ),
      ),
      child: Text(
        title,
        style: context.textTheme.interRegular20.copyWith(
          color: context.colorsExt.secondaryColor,
        ),
      ),
    );
  }
}

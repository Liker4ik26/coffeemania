import 'package:coffee_mania/src/config/styles/dimensions.dart';
import 'package:coffee_mania/src/extensions/context_extensions.dart';
import 'package:coffee_mania/src/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.text,
    this.onSelected,
    required this.selected,
  });

  final String text;
  final bool selected;
  final ValueChanged<bool>? onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      selected: selected,
      selectedColor: context.colorsExt.accentColor,
      backgroundColor: context.colorsExt.backgroundSecondaryColor,
      showCheckmark: false,
      autofocus: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.medium),
        side: const BorderSide(color: Colors.transparent),
      ),
      label: Text(
        text,
        style: context.textTheme.interRegular14.copyWith(
          color: selected
              ? Colors.white
              : context.colorsExt.primaryColor.withOpacity(.5),
        ),
      ),
      onSelected: onSelected,
    ).paddingSymmetric(horizontal: 8);
  }
}

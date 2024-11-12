import 'package:coffee_mania/src/config/styles/dimensions.dart';
import 'package:coffee_mania/src/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

extension SnackbarUtils on BuildContext {
  void showSnackbar({
    required String title,
    Color? backgroundColor,
    Color? textColor,
    required BuildContext context,
  }) {
    showTopSnackBar(
      Overlay.of(context),
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.small,
          ),
        ),
        color: backgroundColor ?? context.colorsExt.backgroundSecondaryColor,
        child: Container(
          height: 60,
          padding: const EdgeInsets.all(12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: context.textTheme.interRegular14.copyWith(
                color: context.colorsExt.primaryColor,
              ),
            ),
          ),
        ),
      ),
      displayDuration: const Duration(seconds: 2),
    );
  }
}

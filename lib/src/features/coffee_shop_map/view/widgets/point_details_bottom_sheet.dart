import 'package:coffee_mania/src/common/widgets/custom_button.dart';
import 'package:coffee_mania/src/config/styles/dimensions.dart';
import 'package:coffee_mania/src/extensions/context_extensions.dart';
import 'package:coffee_mania/src/extensions/widget_extensions.dart';
import 'package:coffee_mania/src/map/domain/model/map_point.dart';
import 'package:flutter/material.dart';

void showPointDetailsBottomSheet({
  required BuildContext context,
  required MapPoint location,
  required VoidCallback onClickSelected,
}) {
  showModalBottomSheet(
    enableDrag: true,
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: context.colorsExt.backgroundSecondaryColor,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.medium),
          color: context.colorsExt.backgroundSecondaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              location.name,
              style: context.textTheme.interBold24,
            ),
            const SizedBox(height: 30),
            CustomButton(
              onPressed: onClickSelected,
              title: context.tr.selectMapScreenBottomSheet,
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
      );
    },
  );
}

import 'package:coffee_mania/generated/assets.dart';
import 'package:coffee_mania/src/common/widgets/custom_button.dart';
import 'package:coffee_mania/src/common/widgets/svg_icon.dart';
import 'package:coffee_mania/src/config/styles/dimensions.dart';
import 'package:coffee_mania/src/extensions/context_extensions.dart';
import 'package:coffee_mania/src/extensions/widget_extensions.dart';
import 'package:coffee_mania/src/features/coffee_list/view/widgets/cart_item.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';

void showCartBottomSheet({
  required BuildContext context,
  required List<CoffeeDomain> products,
  required VoidCallback onClickDelete,
  required VoidCallback onClickPlaceOrder,
}) {
  showModalBottomSheet(
    enableDrag: true,
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: context.colorsExt.backgroundSecondaryColor,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.medium),
          color: context.colorsExt.backgroundSecondaryColor,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.tr.titleBottomSheet,
                  style: context.textTheme.interBold24,
                ),
                IconButton(
                  onPressed: onClickDelete,
                  icon: SvgIcon(
                    icon: Assets.iconsDeleteTrash,
                    color: context.colorsExt.primaryColor.withOpacity(.5),
                    height: 24,
                    width: 24,
                  ),
                ).paddingSymmetric(horizontal: 14),
              ],
            ).paddingSymmetric(horizontal: 10),
            const Divider(
              thickness: 1,
            ).paddingSymmetric(horizontal: 10),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) => CartItem(
                  product: products[index],
                ),
              ),
            ),
            SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(
                  onPressed: onClickPlaceOrder,
                  title: context.tr.placeAnOrderBottomSheet,
                ),
              ),
            ).paddingAll(10),
          ],
        ),
      );
    },
  );
}

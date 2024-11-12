import 'package:coffee_mania/generated/assets.dart';
import 'package:coffee_mania/src/common/utils/utils.dart';
import 'package:coffee_mania/src/common/widgets/card_image.dart';
import 'package:coffee_mania/src/common/widgets/svg_icon.dart';
import 'package:coffee_mania/src/config/styles/dimensions.dart';
import 'package:coffee_mania/src/extensions/context_extensions.dart';
import 'package:coffee_mania/src/extensions/widget_extensions.dart';
import 'package:coffee_mania/src/features/coffee_list/provider/cart_provider.dart';
import 'package:coffee_mania/src/features/coffee_list/provider/error_provider.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final CoffeeDomain product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);
    final quantity = cartState.getQuantity(product.id);
    final isAddedToCart = quantity > 0;
    final error = ref.read(errorProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: context.colorsExt.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(AppDimensions.medium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CardImage(
            fit: BoxFit.cover,
            imageUrl: product.imageUrl,
            height: 100,
            borderRadius: BorderRadius.circular(AppDimensions.small),
          ),
          const SizedBox(height: 16),
          Text(
            product.name,
            style: context.textTheme.interMedium16,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          if (!isAddedToCart)
            SizedBox(
              height: 30,
              child: TextButton(
                onPressed: () =>
                    ref.read(cartProvider.notifier).addProduct(product),
                style: TextButton.styleFrom(
                  backgroundColor: context.colorsExt.accentColor,
                  minimumSize: Size(
                    MediaQuery.of(context).size.width * 0.4,
                    24,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.medium),
                  ),
                ),
                child: Text(
                  '${product.prices.first.value} '
                  '${product.prices.first.currency}',
                  style: context.textTheme.interRegular12.copyWith(
                    color: context.colorsExt.secondaryColor,
                  ),
                ),
              ),
            ).paddingSymmetric(horizontal: 16)
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: IconButton(
                    style: TextButton.styleFrom(
                      backgroundColor: context.colorsExt.accentColor,
                    ),
                    onPressed: () {
                      ref.read(cartProvider.notifier).removeProduct(product);
                      if (error != null) {
                        context.showSnackbar(title: error, context: context);
                        ref.read(errorProvider.notifier).resetError();
                      }
                    },
                    icon: SvgIcon(
                      icon: Assets.iconsDelete,
                      color: context.colorsExt.secondaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: context.colorsExt.accentColor,
                    borderRadius: BorderRadius.circular(AppDimensions.medium),
                  ),
                  child: Text(
                    quantity.toString(),
                    style: context.textTheme.interRegular12.copyWith(
                      color: context.colorsExt.secondaryColor,
                    ),
                  ).paddingSymmetric(horizontal: 22, vertical: 6),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: IconButton(
                    style: TextButton.styleFrom(
                      backgroundColor: context.colorsExt.accentColor,
                    ),
                    color: context.colorsExt.accentColor,
                    onPressed: () {
                      ref.read(cartProvider.notifier).addProduct(product);
                      if (error != null) {
                        context.showSnackbar(title: error, context: context);
                        ref.read(errorProvider.notifier).resetError();
                      }
                    },
                    icon: SvgIcon(
                      icon: Assets.iconsAdd,
                      color: context.colorsExt.secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ).paddingSymmetric(vertical: 16),
    );
  }
}

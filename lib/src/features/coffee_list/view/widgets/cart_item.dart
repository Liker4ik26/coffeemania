import 'package:coffee_mania/src/common/widgets/card_image.dart';
import 'package:coffee_mania/src/config/styles/dimensions.dart';
import 'package:coffee_mania/src/extensions/context_extensions.dart';
import 'package:coffee_mania/src/extensions/widget_extensions.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.product,
  });

  final CoffeeDomain product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CardImage(
          imageUrl: product.imageUrl,
          borderRadius: BorderRadius.circular(AppDimensions.medium),
          height: 70,
          width: 70,
        ),
        const SizedBox(width: 10),
        Text(
          product.name,
          style: context.textTheme.interMedium16,
        ),
        const Spacer(),
        Text(
          '${product.prices[0].value} ${product.prices[0].currency}',
          style: context.textTheme.interMedium16,
        ),
      ],
    ).paddingAll(10);
  }
}

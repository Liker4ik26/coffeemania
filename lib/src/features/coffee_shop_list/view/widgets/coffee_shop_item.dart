import 'package:coffee_mania/generated/assets.dart';
import 'package:coffee_mania/src/common/widgets/svg_icon.dart';
import 'package:coffee_mania/src/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class CoffeeShopItem extends StatelessWidget {
  const CoffeeShopItem({super.key, required this.title, this.onTap});

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: context.textTheme.interRegular14,
      ),
      trailing: const SvgIcon(icon: Assets.iconsArrowForward),
      onTap: onTap,
    );
  }
}

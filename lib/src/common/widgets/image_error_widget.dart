import 'package:coffee_mania/generated/assets.dart';
import 'package:coffee_mania/src/common/widgets/svg_icon.dart';
import 'package:coffee_mania/src/config/styles/dimensions.dart';
import 'package:coffee_mania/src/extensions/context_extensions.dart';
import 'package:flutter/cupertino.dart';

class ImageErrorWidget extends StatelessWidget {
  const ImageErrorWidget({super.key, this.bgColor});

  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimensions.medium),
      child: Container(
        color: bgColor ?? context.colorsExt.primaryColor,
        child: const SvgIcon(
          icon: Assets.iconsErrorIcon,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}

import 'package:coffee_mania/src/config/styles/extensions/extensions.dart';
import 'package:coffee_mania/src/config/styles/extensions/text_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ContextExtensions on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this);

  ThemeColors get colorsExt => Theme.of(this).extension<ThemeColors>()!;

  Size get mediaQuerySize => MediaQuery.of(this).size;

  ThemeData get theme => Theme.of(this);

  bool get isDarkMode => theme.brightness == Brightness.dark;

  AppTextTheme get textTheme => Theme.of(this).extension<AppTextTheme>()!;

  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).padding;

  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

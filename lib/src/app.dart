import 'package:coffee_mania/src/config/navigation/router/routes.dart';
import 'package:coffee_mania/src/config/styles/styles.dart';
import 'package:coffee_mania/src/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final platformBrightness = context.mediaQuery.platformBrightness;
    final focusManager = FocusManager.instance;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: platformBrightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
    );

    return GestureDetector(
      onTap: () => focusManager.primaryFocus?.unfocus(),
      child: ProviderScope(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppThemes.light,
          darkTheme: AppThemes.dark,
          initialRoute: Routes.coffeeListRoute,
          routes: Routes.all,
          // routes: {
          //   Routes.coffeeListRoute: (context) => const CoffeeListScreen(),
          //   Routes.mapRoute: (context) => const CoffeeShopMapScreen(),
          //   Routes.coffeeShopListRoute: (context) =>
          //       const CoffeeShopListScreen(),
          // },
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }
}

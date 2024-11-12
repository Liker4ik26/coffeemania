import 'package:coffee_mania/src/common/widgets/custom_button.dart';
import 'package:coffee_mania/src/config/navigation/router/routes.dart';
import 'package:coffee_mania/src/extensions/context_extensions.dart';
import 'package:coffee_mania/src/extensions/widget_extensions.dart';
import 'package:coffee_mania/src/features/coffee_list/provider/coffee_provider.dart';
import 'package:coffee_mania/src/features/coffee_shop_list/provider/coffee_shop_list_provider.dart';
import 'package:coffee_mania/src/features/coffee_shop_list/view/widgets/coffee_shop_item.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'coffee_shop_list_screen.g.dart';

@riverpod
Future<List<LocationDomain>> locations(LocationsRef ref) async {
  final repository = ref.watch(coffeeRepositoryProvider);
  final locationsList = await repository.getLocations();
  return locationsList;
}

class CoffeeShopListScreen extends ConsumerStatefulWidget {
  const CoffeeShopListScreen({super.key});

  @override
  ConsumerState<CoffeeShopListScreen> createState() => _CoffeeShopListScreen();
}

class _CoffeeShopListScreen extends ConsumerState<CoffeeShopListScreen> {
  @override
  Widget build(BuildContext context) {
    final locationsData = ref.watch(locationsProvider);

    // return locationsData.when(
    //   data: data,
    //   error: error,
    //   loading: loading,
    // );

    if (locationsData is AsyncLoading) {
      return Material(
        color: context.colorsExt.backgroundPrimaryColor,
        child: Center(
          child: CircularProgressIndicator(
            color: context.colorsExt.accentColor,
          ),
        ),
      );
    }

    if (locationsData is AsyncError) {
      return Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(locationsData.asError.toString()),
            const SizedBox(height: 12),
            CustomButton(
              onPressed: () => ref.refresh(locationsProvider.future),
              title: context.tr.reboot,
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
      );
    }

    return Scaffold(
      backgroundColor: context.colorsExt.backgroundPrimaryColor,
      appBar: AppBar(
        backgroundColor: context.colorsExt.backgroundPrimaryColor,
        title: Text(
          context.tr.ourCoffeeShops,
          style: context.textTheme.interBold24,
        ),
      ),
      body: Column(
        children: [
          const Divider(
            thickness: 1,
          ).paddingSymmetric(horizontal: 16),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: locationsData.value!.length,
              itemBuilder: (context, index) => CoffeeShopItem(
                title: locationsData.value![index].address,
                onTap: () async {
                  await ref
                      .read(addressNotifierProvider.notifier)
                      .saveAddress(locationsData.value![index].address);
                  await Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.coffeeListRoute,
                    (route) => false,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

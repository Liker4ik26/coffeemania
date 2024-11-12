import 'package:coffee_mania/generated/assets.dart';
import 'package:coffee_mania/src/common/utils/show_cart_bottom_sheet.dart';
import 'package:coffee_mania/src/common/utils/utils.dart';
import 'package:coffee_mania/src/common/widgets/custom_button.dart';
import 'package:coffee_mania/src/common/widgets/svg_icon.dart';
import 'package:coffee_mania/src/config/navigation/router/routes.dart';
import 'package:coffee_mania/src/extensions/context_extensions.dart';
import 'package:coffee_mania/src/extensions/widget_extensions.dart';
import 'package:coffee_mania/src/features/coffee_list/provider/cart_provider.dart';
import 'package:coffee_mania/src/features/coffee_list/provider/coffee_provider.dart';
import 'package:coffee_mania/src/features/coffee_list/provider/error_provider.dart';
import 'package:coffee_mania/src/features/coffee_list/view/widgets/categories_list.dart';
import 'package:coffee_mania/src/features/coffee_list/view/widgets/product_card.dart';
import 'package:coffee_mania/src/features/coffee_shop_list/provider/coffee_shop_list_provider.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'coffee_list_screen.g.dart';

@riverpod
Future<List<CoffeeDomain>> products(ProductsRef ref) async {
  final repository = ref.watch(coffeeRepositoryProvider);
  final productsList = await repository.getProducts();
  return productsList;
}

@riverpod
Future<List<CategoryDomain>> categories(CategoriesRef ref) async {
  final repository = ref.watch(coffeeRepositoryProvider);
  final categoriesList = await repository.getCategories();
  return categoriesList;
}

class CoffeeListScreen extends StatefulHookConsumerWidget {
  const CoffeeListScreen({super.key});

  @override
  ConsumerState<CoffeeListScreen> createState() => _CoffeeListScreenState();
}

class _CoffeeListScreenState extends ConsumerState<CoffeeListScreen>
    with SingleTickerProviderStateMixin {
  late final ItemPositionsListener _itemPositionsListener;
  late final ItemScrollController _itemScrollController;
  int _selectedCategoryIndex = 0;
  bool _isScrollingProgrammatically = false;

  @override
  void initState() {
    super.initState();
    _itemPositionsListener = ItemPositionsListener.create();
    _itemScrollController = ItemScrollController();

    _itemPositionsListener.itemPositions.addListener(() {
      if (!_isScrollingProgrammatically) {
        final visibleItems = _itemPositionsListener.itemPositions.value;
        if (visibleItems.isNotEmpty) {
          final firstVisibleIndex = visibleItems.first.index;
          if (_selectedCategoryIndex != firstVisibleIndex) {
            setState(() {
              _selectedCategoryIndex = firstVisibleIndex;
            });
          }
        }
      }
    });
  }

  Future<void> _scrollToCategory(int index) async {
    if (_selectedCategoryIndex != index) {
      setState(() {
        _isScrollingProgrammatically = true;
      });
      if (_itemScrollController.isAttached) {
        await _itemScrollController.scrollTo(
          index: index,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
      setState(() {
        _isScrollingProgrammatically = false;
        _selectedCategoryIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productData = ref.watch(productsProvider);
    final categoryData = ref.watch(categoriesProvider);
    final cartData = ref.watch(cartProvider);
    final address = ref.watch(addressNotifierProvider);

    ref.read(addressNotifierProvider.notifier).loadAddress();

    ref.listen<String?>(errorProvider, (previous, next) {
      if (next != null) {
        context.showSnackbar(title: next, context: context);
        ref.read(errorProvider.notifier).resetError();
      }
    });

    if (productData is AsyncLoading || categoryData is AsyncLoading) {
      return Material(
        color: context.colorsExt.backgroundPrimaryColor,
        child: Center(
          child: CircularProgressIndicator(
            color: context.colorsExt.accentColor,
          ),
        ),
      );
    }

    if (productData is AsyncError || categoryData is AsyncError) {
      return Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(productData.asError.toString()),
            const SizedBox(height: 12),
            CustomButton(
              onPressed: () => ref.refresh(productsProvider.future),
              title: context.tr.reboot,
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
      );
    }

    return RefreshIndicator(
      backgroundColor: context.colorsExt.backgroundPrimaryColor,
      onRefresh: () => ref.refresh(categoriesProvider.future),
      color: context.colorsExt.accentColor,
      child: Scaffold(
        floatingActionButton: cartData.items.isEmpty
            ? null
            : FloatingActionButton.extended(
                onPressed: () {
                  showCartBottomSheet(
                    context: context,
                    products: cartData.items,
                    onClickDelete: () {
                      ref.read(cartProvider.notifier).clearCart();
                      Navigator.pop(context);
                    },
                    onClickPlaceOrder: () {
                      ref.read(cartProvider.notifier).createOrder(
                        context: context,
                        positions: {
                          for (final item in cartData.items)
                            item.id.toString(): cartData.getQuantity(item.id),
                        },
                      );
                      Navigator.pop(context);
                    },
                  );
                },
                backgroundColor: context.colorsExt.accentColor,
                label: Row(
                  children: [
                    SvgIcon(
                      icon: Assets.iconsShop,
                      color: context.colorsExt.secondaryColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      cartData.totalCost.toString(),
                      style: context.textTheme.interRegular14.copyWith(
                        color: context.colorsExt.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
        backgroundColor: context.colorsExt.backgroundPrimaryColor,
        appBar: AppBar(
          toolbarHeight: 120,
          backgroundColor: context.colorsExt.backgroundPrimaryColor,
          titleSpacing: 0,
          title: Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.mapRoute);
                },
                child: Row(
                  children: [
                    SvgIcon(
                      icon: Assets.iconsLocation,
                      color: context.colorsExt.accentColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      address ?? context.tr.chooseAddress,
                      style: context.textTheme.interRegular14,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              CategoriesList(
                types: categoryData.value!,
                selectedCategory: _selectedCategoryIndex,
                onSelected: _scrollToCategory,
              ),
            ],
          ),
        ),
        body: ScrollablePositionedList.builder(
          itemScrollController: _itemScrollController,
          itemPositionsListener: _itemPositionsListener,
          itemCount: categoryData.value!.length,
          itemBuilder: (context, categoryIndex) {
            final category = categoryData.value![categoryIndex];
            final products = productData.value!
                .where((product) => product.category.slug == category.slug)
                .toList();
            return RepaintBoundary(
              key: ValueKey(categoryIndex),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      category.slug,
                      style: context.textTheme.interSemibold32,
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio:
                          (MediaQuery.of(context).size.width / 2) / 250,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: products[index]);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

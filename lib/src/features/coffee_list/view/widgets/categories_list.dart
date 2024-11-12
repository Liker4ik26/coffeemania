import 'package:coffee_mania/src/features/coffee_list/view/widgets/custom_chip.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({
    super.key,
    required this.types,
    required this.selectedCategory,
    this.onSelected,
  });

  final List<CategoryDomain> types;
  final int selectedCategory;
  final void Function(int)? onSelected;

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  late List<GlobalKey> _chipKeys;
  int _lastScrolledToIndex = 1;

  @override
  void initState() {
    super.initState();
    _chipKeys = List.generate(widget.types.length, (index) => GlobalKey());
  }

  void _scrollToSelectedCategory(int index) {
    if (_lastScrolledToIndex != index) {
      final context = _chipKeys[index].currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
      _lastScrolledToIndex = index;
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedCategory(widget.selectedCategory);
    });

    return SizedBox(
      height: 40,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: widget.types.length,
        itemBuilder: (context, index) {
          return CustomChip(
            key: _chipKeys[index],
            text: widget.types[index].slug,
            selected: widget.selectedCategory == index,
            onSelected: (isSelected) {
              if (isSelected && widget.onSelected != null) {
                widget.onSelected!(index);
              }
            },
          );
        },
      ),
    );
  }
}

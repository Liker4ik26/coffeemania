import 'package:coffee_repository/src/domain/models/category_domain.dart';
import 'package:coffee_repository/src/domain/models/price_domain.dart';
import 'package:equatable/equatable.dart';

class CoffeeDomain extends Equatable {
  const CoffeeDomain({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.prices,
  });

  factory CoffeeDomain.fromMap(Map<String, dynamic> map) {
    return CoffeeDomain(
      id: map['id_product'] ?? 0,
      name: map['name'] as String,
      description: map['description'] ?? '',
      imageUrl: map['image'] as String?,
      category: CategoryDomain.fromSlug(map['category'] as String),
      prices: [PriceDomain.fromString(map['price'] as String)],
    );
  }

  final int id;
  final String name;
  final String description;
  final CategoryDomain category;
  final String? imageUrl;
  final List<PriceDomain> prices;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        category,
        imageUrl,
        prices,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id_product': id,
      'name': name,
      'image': imageUrl,
      'price': '${prices[0].value}+${prices[0].currency}',
      'category': category.slug,
    };
  }
}

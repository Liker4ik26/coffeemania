import 'package:equatable/equatable.dart';

class CategoryDomain extends Equatable {
  const CategoryDomain({
    required this.id,
    required this.slug,
  });

  factory CategoryDomain.fromSlug(String slug) {
    return CategoryDomain(id: 0, slug: slug);
  }

  final int id;
  final String slug;

  @override
  List<Object?> get props => [
        id,
        slug,
      ];
}

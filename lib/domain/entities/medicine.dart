// lib/domain/entities/medicine.dart
class Medicine {
  final String id;
  final String name;
  final String kind;
  final String description;
  final String? instructions;
  final String? sideEffects;
  final double price;
  final bool inStock;
  final int? stockCount;
  final String? expiry;
  final String? imageUrl;

  const Medicine({
    required this.id,
    required this.name,
    required this.kind,
    required this.description,
    this.instructions,
    this.sideEffects,
    required this.price,
    required this.inStock,
    this.stockCount,
    this.expiry,
    this.imageUrl,
  });
}

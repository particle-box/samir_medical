// lib/domain/repositories/catalog_repository.dart
import 'package:samir_medical/domain/entities/medicine.dart';

class CatalogRepository {
  static final List<Medicine> _mock = [
    Medicine(
      id: '1',
      name: 'Paracetamol 500mg',
      kind: 'Tablet',
      description: 'Pain reliever and fever reducer.',
      price: 18.0,
      inStock: true,
      stockCount: 42,
      imageUrl: null,
    ),
    Medicine(
      id: '2',
      name: 'Cough Syrup DX',
      kind: 'Syrup',
      description: 'Soothes cough and throat irritation.',
      price: 120.0,
      inStock: true,
      stockCount: 15,
      imageUrl: null,
    ),
    Medicine(
      id: '3',
      name: 'Amoxicillin 250mg',
      kind: 'Capsule',
      description: 'Antibiotic for bacterial infections.',
      price: 95.5,
      inStock: false,
      stockCount: 0,
      imageUrl: null,
    ),
    Medicine(
      id: '4',
      name: 'Vitamin D3 Drops',
      kind: 'Other',
      description: 'Supports bone health and immunity.',
      price: 210.0,
      inStock: true,
      stockCount: 8,
      imageUrl: null,
    ),
    Medicine(
      id: '5',
      name: 'Cetirizine 10mg',
      kind: 'Tablet',
      description: 'Allergy relief antihistamine.',
      price: 30.0,
      inStock: true,
      stockCount: 28,
      imageUrl: null,
    ),
    Medicine(
      id: '6',
      name: 'Azithromycin 500mg',
      kind: 'Tablet',
      description: 'Antibiotic for infections.',
      price: 180.0,
      inStock: false,
      stockCount: 0,
      imageUrl: null,
    ),
    Medicine(
      id: '7',
      name: 'ORS Solution',
      kind: 'Other',
      description: 'Electrolyte replenishment for dehydration.',
      price: 44.0,
      inStock: true,
      stockCount: 60,
      imageUrl: null,
    ),
    Medicine(
      id: '8',
      name: 'Metformin 500mg',
      kind: 'Tablet',
      description: 'For type 2 diabetes control.',
      price: 35.0,
      inStock: true,
      stockCount: 32,
      imageUrl: null,
    ),
    Medicine(
      id: '9',
      name: 'Albendazole Syrup',
      kind: 'Syrup',
      description: 'Deworming syrup for children.',
      price: 78.0,
      inStock: true,
      stockCount: 20,
      imageUrl: null,
    ),
    Medicine(
      id: '10',
      name: 'Hydrocortisone Cream',
      kind: 'Other',
      description: 'Topical anti-inflammatory; for skin irritation.',
      price: 65.0,
      inStock: true,
      stockCount: 17,
      imageUrl: null,
    ),
    Medicine(
      id: '11',
      name: 'Pantoprazole 40mg',
      kind: 'Tablet',
      description: 'Reduces stomach acid.',
      price: 54.0,
      inStock: true,
      stockCount: 25,
      imageUrl: null,
    ),
    Medicine(
      id: '12',
      name: 'Ibuprofen 400mg',
      kind: 'Tablet',
      description: 'Nonsteroidal anti-inflammatory painkiller.',
      price: 22.0,
      inStock: true,
      stockCount: 40,
      imageUrl: null,
    ),
    Medicine(
      id: '13',
      name: 'Ranitidine Syrup',
      kind: 'Syrup',
      description: 'For acidity and reflux in children.',
      price: 36.0,
      inStock: false,
      stockCount: 0,
      imageUrl: null,
    ),
    Medicine(
      id: '14',
      name: 'Dolo 650',
      kind: 'Tablet',
      description: 'Fever and pain relief.',
      price: 25.0,
      inStock: true,
      stockCount: 100,
      imageUrl: null,
    ),
    Medicine(
      id: '15',
      name: 'Salbutamol Inhaler',
      kind: 'Other',
      description: 'For asthma symptom relief.',
      price: 320.0,
      inStock: true,
      stockCount: 13,
      imageUrl: null,
    ),
  ];

  Future<List<Medicine>> getCatalog({String? search, String? kind}) async {
    await Future.delayed(const Duration(milliseconds: 300)); // simulate latency
    Iterable<Medicine> list = _mock;

    if (kind != null && kind.isNotEmpty) {
      list = list.where((m) => m.kind.toLowerCase() == kind.toLowerCase());
    }
    if (search != null && search.trim().isNotEmpty) {
      final q = search.trim().toLowerCase();
      list = list.where((m) =>
          m.name.toLowerCase().contains(q) ||
          m.description.toLowerCase().contains(q));
    }
    return list.toList();
  }

  Future<Medicine> getDetail(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _mock.firstWhere((m) => m.id == id, orElse: () => _mock.first);
  }
}

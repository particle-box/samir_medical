import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samir_medical/domain/entities/medicine.dart';
import 'package:samir_medical/domain/repositories/catalog_repository.dart';

class CatalogState {
  final bool isLoading;
  final List<Medicine> items;
  final String? selectedKind;
  final String? searchQuery;
  final String? error;
  const CatalogState({
    this.isLoading = false,
    this.items = const [],
    this.selectedKind,
    this.searchQuery,
    this.error,
  });

  CatalogState copyWith({
    bool? isLoading,
    List<Medicine>? items,
    String? selectedKind,
    String? searchQuery,
    String? error,
  }) {
    return CatalogState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      selectedKind: selectedKind ?? this.selectedKind,
      searchQuery: searchQuery ?? this.searchQuery,
      error: error,
    );
  }
}

class CatalogViewModel extends StateNotifier<CatalogState> {
  CatalogViewModel() : super(const CatalogState()) {
    load();
  }

  final _repo = CatalogRepository();
  final kinds = const ['Tablet', 'Syrup', 'Capsule', 'Injection', 'Other'];
  final TextEditingController searchController = TextEditingController();

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final list = await _repo.getCatalog(
        search: state.searchQuery,
        kind: state.selectedKind,
      );
      state = state.copyWith(items: list, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to load catalog');
    }
  }

  Future<void> refresh() => load();

  Future<void> search(String? q) async {
    state = state.copyWith(searchQuery: q?.trim().isEmpty == true ? null : q?.trim());
    await load();
  }

  Future<void> selectKind(String? k) async {
    state = state.copyWith(selectedKind: k);
    await load();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

final catalogViewModelProvider =
    StateNotifierProvider<CatalogViewModel, CatalogState>((ref) => CatalogViewModel());

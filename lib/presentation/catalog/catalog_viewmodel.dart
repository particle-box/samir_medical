import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samir_medical/domain/entities/medicine.dart';
import 'package:samir_medical/domain/repositories/catalog_repository.dart';

// Sentinel used to distinguish "not provided" from "explicitly set to null"
const _unset = Object();

class CatalogState {
  final bool isLoading;
  final List<Medicine> items;
  final String? selectedKind;
  final String? searchQuery;
  final String? error;
  final bool hasLoadedOnce;

  const CatalogState({
    this.isLoading = false,
    this.items = const [],
    this.selectedKind,
    this.searchQuery,
    this.error,
    this.hasLoadedOnce = false,
  });

  CatalogState copyWith({
    bool? isLoading,
    List<Medicine>? items,
    Object? selectedKind = _unset,
    Object? searchQuery = _unset,
    Object? error = _unset,
    bool? hasLoadedOnce,
  }) {
    return CatalogState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      selectedKind: identical(selectedKind, _unset)
          ? this.selectedKind
          : selectedKind as String?,
      searchQuery: identical(searchQuery, _unset)
          ? this.searchQuery
          : searchQuery as String?,
      error: identical(error, _unset) ? this.error : error as String?,
      hasLoadedOnce: hasLoadedOnce ?? this.hasLoadedOnce,
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
    // Preserve filters; mark loading
    state = state.copyWith(isLoading: true, error: null);
    try {
      final list = await _repo.getCatalog(
        search: state.searchQuery,
        kind: state.selectedKind,
      );
      state = state.copyWith(
        items: list,
        isLoading: false,
        error: null,
        hasLoadedOnce: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load catalog',
        hasLoadedOnce: true,
      );
    }
  }

  Future<void> refresh() => load();

  Future<void> search(String? q) async {
    state = state.copyWith(
      searchQuery: (q?.trim().isEmpty == true) ? null : q?.trim(),
    );
    await load();
  }

  Future<void> selectKind(String? k) async {
    if (state.selectedKind != k) {
      state = state.copyWith(selectedKind: k);
      await load();
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

final catalogViewModelProvider =
    StateNotifierProvider<CatalogViewModel, CatalogState>(
  (ref) => CatalogViewModel(),
);
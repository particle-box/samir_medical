import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samir_medical/domain/entities/medicine.dart';

// One line in the cart
class CartItem {
  final Medicine medicine;
  int quantity;

  CartItem({required this.medicine, this.quantity = 1});
}

class CartState extends StateNotifier<List<CartItem>> {
  CartState() : super([]);

  void addToCart(Medicine m, {int qty = 1}) {
    final idx = state.indexWhere((c) => c.medicine.id == m.id);
    if (idx >= 0) {
      state = [
        ...state.sublist(0, idx),
        CartItem(medicine: m, quantity: state[idx].quantity + qty),
        ...state.sublist(idx + 1)
      ];
    } else {
      state = [...state, CartItem(medicine: m, quantity: qty)];
    }
  }

  void increment(String id) {
    final idx = state.indexWhere((c) => c.medicine.id == id);
    if (idx >= 0) {
      final list = [...state];
      list[idx].quantity += 1;
      state = list;
    }
  }

  void decrement(String id) {
    final idx = state.indexWhere((c) => c.medicine.id == id);
    if (idx >= 0 && state[idx].quantity > 1) {
      final list = [...state];
      list[idx].quantity -= 1;
      state = list;
    }
  }

  void remove(String id) {
    state = state.where((c) => c.medicine.id != id).toList();
  }

  void clear() => state = [];
}

final cartStateProvider = StateNotifierProvider<CartState, List<CartItem>>((ref) => CartState());

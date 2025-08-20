import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samir_medical/core/theme/app_theme.dart';
import 'package:samir_medical/presentation/cart/cart_state.dart';
import 'package:samir_medical/presentation/common/widgets/glass_card.dart';
import 'package:samir_medical/presentation/cart/checkout_address_screen.dart';
import 'package:samir_medical/presentation/cart/checkout_review_screen.dart';
import 'package:samir_medical/presentation/cart/checkout_success_screen.dart';

class CartTab extends ConsumerStatefulWidget {
  const CartTab({super.key});

  @override
  ConsumerState<CartTab> createState() => _CartTabState();
}

class _CartTabState extends ConsumerState<CartTab> {
  int _step = 0;
  String? _name;
  String? _address;
  String? _phone;

  void resetFlow() {
    setState(() {
      _step = 0;
      _name = null;
      _address = null;
      _phone = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top + AppTheme.appBarHeight;
    final items = ref.watch(cartStateProvider);
    final cart = ref.read(cartStateProvider.notifier);

    double total = items.fold(0.0, (sum, item) => sum + item.medicine.price * item.quantity);

    Widget buildPaddedScreen(Widget child) {
      return ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          SizedBox(height: topPadding - 32.0),
          child,
        ],
      );
    }

    if (_step == 1) {
      return buildPaddedScreen(
        CheckoutAddressScreen(
          onNext: (name, address, phone) {
            setState(() {
              _name = name;
              _address = address;
              _phone = phone;
              _step = 2;
            });
          },
        ),
      );
    }

    if (_step == 2 && _name != null && _address != null && _phone != null) {
      return buildPaddedScreen(
        CheckoutReviewScreen(
          name: _name!,
          address: _address!,
          phone: _phone!,
          items: items,
          onPlaceOrder: () {
            setState(() => _step = 3);
            cart.clear(); // clear mock cart
          },
        ),
      );
    }

    if (_step == 3) {
      return CheckoutSuccessScreen(
        onReturnHome: resetFlow,
      );
    }

    if (items.isEmpty) {
      return const Center(
        child: Text(
          "Cart is empty",
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
      children: [
        SizedBox(height: topPadding - 32.0),
        ...items.map((it) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GlassCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(it.medicine.name,
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 6),
                          Text(
                            '₹${it.medicine.price.toStringAsFixed(2)} each',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => cart.decrement(it.medicine.id),
                        ),
                        Text('${it.quantity}'),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () => cart.increment(it.medicine.id),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => cart.remove(it.medicine.id),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
        const SizedBox(height: 8),
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Subtotal'),
                  Text('₹${total.toStringAsFixed(2)}'),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => setState(() => _step = 1),
                child: const Text('Proceed to Checkout'),
              ),
              TextButton(
                onPressed: () => cart.clear(),
                child: const Text('Clear cart'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
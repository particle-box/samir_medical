import 'package:flutter/material.dart';
import 'package:samir_medical/presentation/cart/cart_state.dart';

class CheckoutReviewScreen extends StatelessWidget {
  final String name;
  final String address;
  final String phone;
  final List<CartItem> items;
  final VoidCallback onPlaceOrder;

  const CheckoutReviewScreen({
    super.key,
    required this.name,
    required this.address,
    required this.phone,
    required this.items,
    required this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    double total = items.fold(0.0, (sum, item) => sum + item.medicine.price * item.quantity);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Review Order', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 18),
          Card(
            child: ListTile(
              title: Text('$name\n$address\nPhone: $phone'),
              isThreeLine: true,
            ),
          ),
          const SizedBox(height: 10),
          ...items.map((it) => ListTile(
                title: Text(it.medicine.name),
                subtitle: Text('${it.quantity} × ₹${it.medicine.price.toStringAsFixed(2)}'),
                trailing: Text('₹${(it.quantity * it.medicine.price).toStringAsFixed(2)}'),
              )),
          const SizedBox(height: 6),
          ListTile(
            title: const Text("Total", style: TextStyle(fontWeight: FontWeight.w600)),
            trailing: Text('₹${total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onPlaceOrder,
            child: const Text('Place Order'),
          ),
        ],
      ),
    );
  }
}

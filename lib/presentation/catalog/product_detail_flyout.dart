import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samir_medical/domain/entities/medicine.dart';
import 'package:samir_medical/presentation/cart/cart_state.dart';

class ProductDetailFlyout extends StatefulWidget {
  final Medicine medicine;
  final WidgetRef ref;
  const ProductDetailFlyout({super.key, required this.medicine, required this.ref});

  @override
  State<ProductDetailFlyout> createState() => _ProductDetailFlyoutState();
}

class _ProductDetailFlyoutState extends State<ProductDetailFlyout> {
  int quantity = 1;
  bool notified = false;
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final med = widget.medicine;
    final ref = widget.ref;
    final theme = Theme.of(context);
    final maxHeight = MediaQuery.of(context).size.height * 0.9;
    final backgroundColor = theme.brightness == Brightness.dark
        ? Colors.grey[900]
        : Colors.white;

    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          // Modal card effect
          padding: const EdgeInsets.all(22),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: backgroundColor, // Opaque, always readable
            borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.11),
                blurRadius: 16,
                offset: Offset(0, -8),
              ),
            ],
          ),
          constraints: BoxConstraints(
            maxHeight: maxHeight,
            minWidth: 330,
            maxWidth: 500,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle bar
                Container(
                  height: 3,
                  width: 36,
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/placeholder_medicine.png',
                        width: 84,
                        height: 84,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            med.name,
                            style: theme.textTheme.titleLarge,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(med.kind, style: theme.textTheme.bodySmall),
                          const SizedBox(height: 8),
                          Text(
                            med.inStock
                                ? 'In stock: ${med.stockCount ?? '~'}'
                                : 'Out of stock',
                            style: TextStyle(
                              color: med.inStock
                                  ? Colors.green
                                  : theme.colorScheme.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    med.description,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 14),
                if (med.inStock)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Quantity stepper
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.18)),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: quantity > 1
                                  ? () => setState(() => quantity--)
                                  : null,
                            ),
                            Text('$quantity',
                                style: theme.textTheme.titleMedium),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: (med.stockCount ?? 999) > quantity
                                  ? () => setState(() => quantity++)
                                  : null,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            ref.read(cartStateProvider.notifier).addToCart(med, qty: quantity);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Added to cart! (mock)")));
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Add to Cart  ₹${(med.price * quantity).toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  (notified
                      ? const Center(
                          child: Text(
                            "You’ll be notified when it’s back in stock.",
                            style: TextStyle(color: Colors.green),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Out of stock — Get notified when available:',
                              style: TextStyle(color: Colors.orange),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                labelText: "Your email",
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                setState(() => notified = true);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("You’ll be notified at that email (mock, not sent)")),
                                );
                                Navigator.pop(context);
                              },
                              child: const Text('Notify Me'),
                            )
                          ],
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

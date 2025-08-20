import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samir_medical/domain/entities/medicine.dart';
import 'package:samir_medical/presentation/common/widgets/glass_card.dart';
import 'package:samir_medical/presentation/cart/cart_state.dart';

class ProductDetailScreen extends StatefulWidget {
  final String id;
  const ProductDetailScreen({super.key, required this.id});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  bool notified = false;
  final emailController = TextEditingController();

  // Use the same mock data from your in-memory repo
  Medicine? get mockMedicine {
    final all = [
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
    ];
    return all.firstWhere((m) => m.id == widget.id, orElse: () => all.first);
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final med = mockMedicine;
    if (med == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Product Detail')),
        body: const Center(child: Text('Medicine not found')),
      );
    }

    return Consumer(
      builder: (context, ref, _) {
        return Scaffold(
          appBar: AppBar(title: Text(med.name)),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
            children: [
              GlassCard(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/placeholder_medicine.png',
                        width: 100,
                        height: 100,
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
                            style: Theme.of(context).textTheme.titleLarge,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(med.kind,
                              style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(height: 12),
                          Text(
                            med.inStock
                                ? 'In stock: ${med.stockCount ?? '~'}'
                                : 'Out of stock',
                            style: TextStyle(
                              color: med.inStock
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              GlassCard(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 6),
                    Text(
                      med.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (med.instructions != null) ...[
                      const SizedBox(height: 12),
                      Text('Instructions',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text(med.instructions!),
                    ],
                    if (med.sideEffects != null) ...[
                      const SizedBox(height: 12),
                      Text('Side Effects',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text(med.sideEffects!),
                    ],
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: GlassCard(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
            child: med.inStock
                ? Row(
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
                            Text(
                              '$quantity',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: (med.stockCount ?? 999) > quantity
                                  ? () => setState(() => quantity++)
                                  : null,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Add to cart using the Riverpod provider
                            ref.read(cartStateProvider.notifier).addToCart(med, qty: quantity);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Added to cart! (mock)"),
                              ),
                            );
                          },
                          child: Text(
                            'Add to Cart  ₹${(med.price * quantity).toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  )
                : (notified
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
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              setState(() => notified = true);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    "You’ll be notified at that email (mock, not sent)"),
                              ));
                            },
                            child: const Text('Notify Me'),
                          )
                        ],
                      )),
          ),
        );
      },
    );
  }
}

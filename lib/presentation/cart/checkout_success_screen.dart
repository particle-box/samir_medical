import 'package:flutter/material.dart';

class CheckoutSuccessScreen extends StatelessWidget {
  final VoidCallback onReturnHome;
  const CheckoutSuccessScreen({super.key, required this.onReturnHome});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.green, size: 80),
          const SizedBox(height: 18),
          const Text(
            'Order placed!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Text(
            'We\'ve received your order and will start preparing it shortly.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            icon: const Icon(Icons.home_outlined),
            label: const Text('Return Home'),
            onPressed: onReturnHome,
          )
        ],
      ),
    );
  }
}

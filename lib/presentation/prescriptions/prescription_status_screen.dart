import 'package:flutter/material.dart';
import 'package:samir_medical/presentation/common/widgets/glass_card.dart';

class PrescriptionStatusScreen extends StatelessWidget {
  const PrescriptionStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mockPresc = [
      ('RX-20250812-1023', 'Shipped', DateTime(2025, 8, 12)),
      ('RX-20250728-732', 'Under Review', DateTime(2025, 7, 28)),
      ('RX-20250710-654', 'Rejected', DateTime(2025, 7, 10)),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Prescriptions')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, i) {
          final (id, status, dt) = mockPresc[i];
          return GlassCard(
            child: ListTile(
              leading: const Icon(Icons.receipt_long),
              title: Text(id),
              subtitle: Text('${dt.day}/${dt.month}/${dt.year}'),
              trailing: Text(status,
                  style: TextStyle(
                      color: status == "Shipped"
                          ? Colors.green
                          : status == "Under Review"
                              ? Colors.orange
                              : Colors.red)),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: mockPresc.length,
      ),
    );
  }
}

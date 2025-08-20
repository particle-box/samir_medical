import 'package:flutter/material.dart';
import 'package:samir_medical/presentation/common/widgets/glass_card.dart';

class AppointmentsHistoryScreen extends StatelessWidget {
  const AppointmentsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mockAppts = [
      ('Dr. A. Sen', DateTime(2025, 8, 2, 15, 20), 'Confirmed'),
      ('Dr. R. Gupta', DateTime(2025, 7, 28, 10, 0), 'Completed'),
      ('Dr. P. Sharma', DateTime(2025, 7, 7, 18, 0), 'Cancelled'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Appointment History')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, i) {
          final (doc, dt, status) = mockAppts[i];
          return GlassCard(
            child: ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(doc),
              subtitle: Text('${dt.day}/${dt.month}/${dt.year} at ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}'),
              trailing: Text(status,
                  style: TextStyle(
                      color: status == "Completed"
                          ? Colors.green
                          : status == "Cancelled"
                              ? Colors.red
                              : Theme.of(context).colorScheme.primary)),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: mockAppts.length,
      ),
    );
  }
}

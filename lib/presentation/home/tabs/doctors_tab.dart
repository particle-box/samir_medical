import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:samir_medical/presentation/common/widgets/glass_card.dart';

class DoctorsTab extends StatelessWidget {
  const DoctorsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final doctors = const [
      ('d1', 'Dr. A. Sen', 'Cardiologist'),
      ('d2', 'Dr. P. Sharma', 'Dermatologist'),
      ('d3', 'Dr. R. Gupta', 'General Physician'),
      ('d4', 'Dr. N. Bose', 'Pediatrician'),
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: doctors.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final (id, name, spec) = doctors[i];
        return GlassCard(
          onTap: () => context.push('/doctor/$id'),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                child: Icon(Icons.medical_services,
                    color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(spec, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        );
      },
    );
  }
}

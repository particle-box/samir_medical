import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:samir_medical/presentation/common/widgets/glass_card.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        GlassCard(
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                child: Text('S', style: Theme.of(context).textTheme.titleLarge),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Suryadip Sarkar',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text('suryadip.2008@gmail.com',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        GlassCard(
          onTap: () => context.push('/appointments'),
          child: const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.history),
            title: Text('Appointments history'),
            trailing: Icon(Icons.chevron_right),
          ),
        ),
        const SizedBox(height: 12),
        GlassCard(
          onTap: () => context.push('/prescriptions'),
          child: const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.receipt_long_outlined),
            title: Text('Prescriptions'),
            trailing: Icon(Icons.chevron_right),
          ),
        ),
        const SizedBox(height: 12),
        GlassCard(
          onTap: () => context.push('/settings'),
          child: const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            trailing: Icon(Icons.chevron_right),
          ),
        ),
      ],
    );
  }
}

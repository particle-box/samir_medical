import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:samir_medical/core/theme/app_theme.dart';
import 'package:samir_medical/presentation/common/widgets/glass_card.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top + AppTheme.appBarHeight;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 110),
      children: [
        SizedBox(height: topPadding - 32.0),
        GlassCard(
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                child: Text('A', style: Theme.of(context).textTheme.titleLarge),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('John Doe',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text('john.doe@example.com',
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
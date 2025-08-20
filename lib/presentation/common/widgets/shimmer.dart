// lib/presentation/common/widgets/shimmer.dart
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListShimmer extends StatelessWidget {
  final int itemCount;
  const ListShimmer({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (_, __) => _tile(context),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: itemCount,
    );
  }

  Widget _tile(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white.withOpacity(0.08),
      highlightColor: Colors.white.withOpacity(0.20),
      child: Container(
        height: 84,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samir_medical/core/theme/app_theme.dart';
import 'package:samir_medical/presentation/catalog/catalog_viewmodel.dart';
import 'package:samir_medical/presentation/common/widgets/glass_card.dart';
import 'package:samir_medical/presentation/common/widgets/shimmer.dart';
import 'package:samir_medical/presentation/catalog/product_detail_flyout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

// ---- Flyout Helper ----
void openProductDetailFlyout(BuildContext context, Widget flyoutContent) {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      barrierColor: Colors.black.withOpacity(0.23),
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) => Align(
        alignment: Alignment.bottomCenter,
        child: FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutQuart)),
            child: flyoutContent,
          ),
        ),
      ),
    ),
  );
}
// ------------------------

class CatalogTab extends StatelessWidget {
  const CatalogTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final st = ref.watch(catalogViewModelProvider);
        final vm = ref.read(catalogViewModelProvider.notifier);
        final topPadding = MediaQuery.of(context).padding.top + AppTheme.appBarHeight;

        if (st.isLoading && st.items.isEmpty) {
          return const ListShimmer();
        }

        final headerWidgets = <Widget>[
          TextField(
            controller: vm.searchController,
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search medicines',
            ),
            onSubmitted: vm.search,
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: st.selectedKind == null,
                  onSelected: (_) => vm.selectKind(null),
                ),
                const SizedBox(width: 8),
                ...vm.kinds.map((k) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(k),
                        selected: st.selectedKind == k,
                        onSelected: (_) => vm.selectKind(
                            st.selectedKind == k ? null : k),
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (st.error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                st.error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          if (st.items.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Text('No results'),
              ),
            ),
        ];

        return RefreshIndicator(
          onRefresh: vm.refresh,
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 110),
            itemCount: headerWidgets.length + st.items.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return SizedBox(height: topPadding - 32.0);
              }

              final adjustedIndex = index - 1;
              if (adjustedIndex < headerWidgets.length) {
                return headerWidgets[adjustedIndex];
              }

              final itemIndex = adjustedIndex - headerWidgets.length;
              final m = st.items[itemIndex];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: GlassCard(
                  onTap: () => openProductDetailFlyout(
                    context,
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Consumer(
                        builder: (context, ref, _) => ProductDetailFlyout(
                          medicine: m,
                          ref: ref,
                        ),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: m.imageUrl ?? '',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 80,
                              height: 80,
                              color: Colors.white,
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/placeholder_medicine.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(m.name,
                                style:
                                    Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 4),
                            Text(m.kind,
                                style:
                                    Theme.of(context).textTheme.bodySmall),
                            const SizedBox(height: 6),
                            Text('₹${m.price.toStringAsFixed(2)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall),
                            if (!m.inStock)
                              Text('Out of stock',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .error)),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:samir_medical/presentation/common/widgets/glass_card.dart';
import 'package:samir_medical/presentation/common/widgets/shimmer.dart';
import 'catalog_viewmodel.dart';

class CatalogScreen extends ConsumerStatefulWidget {
  const CatalogScreen({super.key});

  @override
  ConsumerState<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends ConsumerState<CatalogScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final st = ref.watch(catalogViewModelProvider);
    final vm = ref.read(catalogViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicines'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: vm.refresh),
        ],
      ),
      body: st.isLoading && st.items.isEmpty
          ? const ListShimmer()
          : RefreshIndicator(
              onRefresh: vm.refresh,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search medicines',
                    ),
                    onSubmitted: (q) => vm.search(q),
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
                                onSelected: (_) =>
                                    vm.selectKind(st.selectedKind == k ? null : k),
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (st.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(st.error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                    ),
                  if (st.items.isEmpty)
                    const Center(child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text('No results'),
                    )),
                  ...st.items.map((m) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: GlassCard(
                          onTap: () => context.push('/product/${m.id}'),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  m.imageUrl ?? '',
                                  width: 80, height: 80, fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Image.asset(
                                    'assets/images/placeholder_medicine.png',
                                    width: 80, height: 80, fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(m.name, style: Theme.of(context).textTheme.titleMedium),
                                    const SizedBox(height: 4),
                                    Text(m.kind, style: Theme.of(context).textTheme.bodySmall),
                                    const SizedBox(height: 6),
                                    Text('₹${m.price.toStringAsFixed(2)}',
                                        style: Theme.of(context).textTheme.titleSmall),
                                    if (!m.inStock)
                                      Text('Out of stock',
                                          style: TextStyle(
                                              color: Theme.of(context).colorScheme.error)),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
    );
  }
}

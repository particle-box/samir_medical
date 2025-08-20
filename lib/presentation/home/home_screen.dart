import 'package:flutter/material.dart';
import 'package:samir_medical/presentation/common/widgets/glass_bottom_bar.dart';
import 'package:samir_medical/presentation/common/widgets/loading_bar_flash.dart';
import 'tabs/catalog_tab.dart';
import 'tabs/doctors_tab.dart';
import 'tabs/cart_tab.dart';
import 'tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  bool _showLoading = false;

  final _pages = const [
    CatalogTab(),
    DoctorsTab(),
    CartTab(),
    ProfileTab(),
  ];
  final _titles = const ['Catalog', 'Doctors', 'Cart', 'Profile'];

  void _onTabTapped(int newIndex) async {
    if (newIndex == _index) return;
    setState(() {
      _showLoading = true;
      _index = newIndex;
    });
    await Future.delayed(const Duration(milliseconds: 480)); // ~0.5s modern flash
    if (mounted) {
      setState(() {
        _showLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index]),
        actions: [
          if (_index == 0)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {},
            ),
        ],
      ),
      extendBody: true,
      body: Stack(
        children: [
          IndexedStack(
            index: _index,
            children: _pages,
          ),
          if (_showLoading)
            const LoadingBarFlash(duration: Duration(milliseconds: 480)),
        ],
      ),
      bottomNavigationBar: GlassBottomBar(
        currentIndex: _index,
        onTap: _onTabTapped,
        items: const [
          GlassBottomBarItem(icon: Icons.medication_outlined, label: 'Catalog'),
          GlassBottomBarItem(icon: Icons.local_hospital_outlined, label: 'Doctors'),
          GlassBottomBarItem(icon: Icons.shopping_cart_outlined, label: 'Cart'),
          GlassBottomBarItem(icon: Icons.person_outline, label: 'Profile'),
        ],
        height: 72,
        cornerRadius: 28,
        blur: 24,
        backgroundOpacity: 0.12,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:samir_medical/presentation/common/widgets/glass_bottom_bar.dart';
import 'package:samir_medical/presentation/home/tabs/doctors_tab_loader.dart';
import 'tabs/catalog_tab.dart';
import 'tabs/cart_tab.dart';
import 'tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  int _doctorTabKey = 0;

  final _titles = const ['Catalog', 'Doctors', 'Cart', 'Profile'];

  void _onTabTapped(int newIndex) {
    if (newIndex == _index) return;
    
    if (newIndex == 1) {
      setState(() {
        _doctorTabKey++;
      });
    }

    setState(() {
      _index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const CatalogTab(),
      DoctorsTabLoader(key: ValueKey(_doctorTabKey)),
      const CartTab(),
      const ProfileTab(),
    ];

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
      body: IndexedStack(
        index: _index,
        children: pages,
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
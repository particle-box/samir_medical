import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:samir_medical/core/theme/app_theme.dart';
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
  double _scrollOffset = 0.0;

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
    
    final isScrolled = _scrollOffset > 10.0;

    // Define the glass color based on the current theme
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pillColor = isDark
        ? Colors.black.withOpacity(0.25)
        : Colors.white.withOpacity(0.5);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: AppTheme.appBarHeight,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: isScrolled ? 10.0 : 0.0,
              sigmaY: isScrolled ? 10.0 : 0.0,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(
                horizontal: isScrolled ? 16.0 : 0.0,
                vertical: isScrolled ? 8.0 : 0.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: isScrolled ? pillColor : Colors.transparent,
              ),
              child: Text(_titles[_index]),
            ),
          ),
        ),
        actions: [
          if (_index == 0)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {},
            ),
        ],
      ),
      extendBody: true,
      body: NotificationListener<ScrollNotification>(
        onNotification: (scroll) {
          // To avoid unnecessary rebuilds, only update state if needed
          if ((scroll.metrics.pixels > 10.0) != isScrolled) {
            setState(() {
              _scrollOffset = scroll.metrics.pixels;
            });
          }
          return true;
        },
        child: IndexedStack(
          index: _index,
          children: pages,
        ),
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
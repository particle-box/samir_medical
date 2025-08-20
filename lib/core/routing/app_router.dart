import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:samir_medical/presentation/onboarding/onboarding_screen.dart';
import 'package:samir_medical/presentation/home/home_screen.dart';
import 'package:samir_medical/presentation/auth/login_screen.dart';
import 'package:samir_medical/presentation/auth/register_screen.dart';
import 'package:samir_medical/presentation/catalog/catalog_screen.dart';
import 'package:samir_medical/presentation/catalog/product_detail_screen.dart';
import 'package:samir_medical/presentation/doctors/doctors_screen.dart';
import 'package:samir_medical/presentation/doctors/doctor_detail_screen.dart';
import 'package:samir_medical/presentation/cart/cart_screen.dart';
import 'package:samir_medical/presentation/cart/checkout_screen.dart';
import 'package:samir_medical/presentation/cart/address_picker_screen.dart';
import 'package:samir_medical/presentation/prescriptions/upload_prescription_screen.dart';
import 'package:samir_medical/presentation/prescriptions/prescription_status_screen.dart';
import 'package:samir_medical/presentation/profile/profile_screen.dart';
import 'package:samir_medical/presentation/profile/settings_screen.dart';
import 'package:samir_medical/presentation/appointments/appointments_history_screen.dart';
import 'package:samir_medical/presentation/common/viewmodels/session_controller.dart';

final routerProvider = Provider<GoRouter>((ref) {
  bool isLoggedIn() => ref.read(sessionControllerProvider).isLoggedIn;

  String? guard(BuildContext context, GoRouterState state) {
    if (!isLoggedIn()) return '/login';
    return null;
  }

  return GoRouter(
    initialLocation: '/', // start at Home now
    routes: [
      GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
      GoRoute(path: '/', builder: (_, __) => const HomeScreen()),

      // detail routes used from tabs
      GoRoute(path: '/catalog', builder: (_, __) => const CatalogScreen()),
      GoRoute(path: '/product/:id', builder: (c, s) => ProductDetailScreen(id: s.pathParameters['id']!)),
      GoRoute(path: '/doctors', builder: (_, __) => const DoctorsScreen()),
      GoRoute(path: '/doctor/:id', builder: (c, s) => DoctorDetailScreen(id: s.pathParameters['id']!)),

      GoRoute(path: '/cart', builder: (_, __) => const CartScreen()),
      GoRoute(path: '/checkout', builder: (_, __) => const CheckoutScreen(), redirect: guard),
      GoRoute(path: '/address', builder: (_, __) => const AddressPickerScreen(), redirect: guard),

      GoRoute(path: '/upload', builder: (_, __) => const UploadPrescriptionScreen(), redirect: guard),
      GoRoute(path: '/prescriptions', builder: (_, __) => const PrescriptionStatusScreen(), redirect: guard),

      GoRoute(path: '/appointments', builder: (_, __) => const AppointmentsHistoryScreen(), redirect: guard),
      GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
      GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
    ],
  );
});

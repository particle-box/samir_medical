import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samir_medical/presentation/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Make system navigation and status bars transparent for glass/floating effect
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light, // or Brightness.dark
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // or Brightness.dark
    ),
  );

  runApp(
    ProviderScope(
      child: SamirMedicalApp(),
    ),
  );
}

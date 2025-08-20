import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:samir_medical/presentation/home/tabs/doctors_tab.dart';

class DoctorsTabLoader extends StatefulWidget {
  const DoctorsTabLoader({super.key});

  @override
  _DoctorsTabLoaderState createState() => _DoctorsTabLoaderState();
}

class _DoctorsTabLoaderState extends State<DoctorsTabLoader> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // This timer will now correctly run every time this widget is created.
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // THE FIX: Replaced Center with Align to move the animation up.
      return Align(
        alignment: const Alignment(0.0, -0.3), // Adjust this value to move it up or down
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              // Make sure you are using the .json file that works
              'assets/lottie/doctor_loader.json',
              width: 400,
              height: 400,
              delegates: LottieDelegates(
                values: [
                  // This delegate finds any layer named "Background" and makes it transparent
                  ValueDelegate.color(
                    const ['Background', '**'],
                    value: Colors.transparent,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Gathering available information...',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    } else {
      return const DoctorsTab();
    }
  }
}
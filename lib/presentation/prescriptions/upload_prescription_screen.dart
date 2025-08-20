import 'package:flutter/material.dart';

class UploadPrescriptionScreen extends StatelessWidget {
  const UploadPrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Prescription'),
      ),
      body: const Center(
        child: Text('Upload prescription placeholder'),
      ),
    );
  }
}
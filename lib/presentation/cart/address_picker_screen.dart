import 'package:flutter/material.dart';

class AddressPickerScreen extends StatelessWidget {
  const AddressPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address Picker'),
      ),
      body: const Center(
        child: Text('Address picker placeholder'),
      ),
    );
  }
}
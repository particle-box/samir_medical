import 'package:flutter/material.dart';

class DoctorDetailScreen extends StatelessWidget {
  final String id;
  const DoctorDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Detail: $id'),
      ),
      body: Center(
        child: Text('Doctor detail placeholder for id: $id'),
      ),
    );
  }
}

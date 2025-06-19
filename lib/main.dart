import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(KaryawanApp());
}

class KaryawanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Karyawan',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: HomeScreen(),
    );
  }
}

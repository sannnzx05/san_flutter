
import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const AplikasiAkademik());
}

class AplikasiAkademik extends StatelessWidget {
  const AplikasiAkademik({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Akademik - Milestone 2 (CRUD)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

// Kompatibilitas dengan widget test Milestone 1.
class MyApp extends AplikasiAkademik {
  const MyApp({super.key});
}

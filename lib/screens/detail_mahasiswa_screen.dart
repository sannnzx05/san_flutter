
import 'package:flutter/material.dart';
import '../models/mahasiswa.dart';
import '../widgets/baris_info.dart';

class DetailMahasiswaScreen extends StatelessWidget {
  final Mahasiswa mahasiswa;

  const DetailMahasiswaScreen({
    super.key,
    required this.mahasiswa,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Mahasiswa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),

            const CircleAvatar(
              radius: 45,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              mahasiswa.nama,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 24),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    BarisInfo(
                      ikon: Icons.badge,
                      label: 'NIM',
                      nilai: mahasiswa.nim,
                    ),
                    const Divider(),

                    BarisInfo(
                      ikon: Icons.school,
                      label: 'Program Studi',
                      nilai: mahasiswa.prodi,
                    ),
                    const Divider(),

                    BarisInfo(
                      ikon: Icons.calendar_month,
                      label: 'Semester',
                      nilai: mahasiswa.semester.toString(),
                    ),
                    const Divider(),

                    BarisInfo(
                      ikon: Icons.email,
                      label: 'Email',
                      nilai: mahasiswa.email,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

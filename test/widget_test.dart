
import 'package:flutter_test/flutter_test.dart';
import 'package:san_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:san_flutter/services/akademik_service.dart';

void main() {
  testWidgets('Dashboard Akademik tampil dengan benar',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Dashboard Akademik'), findsOneWidget);
    expect(find.text('Mahasiswa'), findsOneWidget);
    expect(find.text('Mata Kuliah'), findsOneWidget);
    expect(find.text('Daftar Mahasiswa'), findsOneWidget);
    expect(find.text('Total: 3'), findsOneWidget);

    expect(find.text('Rina Amelia'), findsOneWidget);
    expect(find.text('Budi Santoso'), findsOneWidget);
    expect(find.text('Siti Rahma'), findsOneWidget);

    expect(find.text('Tambah Mahasiswa'), findsOneWidget);
  });

  testWidgets('Tab Mata Kuliah menampilkan daftar mata kuliah',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Mata Kuliah'));
    await tester.pumpAndSettle();

    expect(find.text('Daftar Mata Kuliah'), findsOneWidget);
    expect(find.text('Pemrograman Mobile'), findsOneWidget);
    expect(find.text('Rekayasa Perangkat Lunak'), findsOneWidget);
    expect(find.text('Total: 2'), findsOneWidget);
  });

  testWidgets('Tombol Tambah membuka halaman form',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah Mahasiswa'));
    await tester.pumpAndSettle();

    expect(find.text('Tambah Mahasiswa'), findsOneWidget);
    expect(find.text('Nama Lengkap'), findsOneWidget);
    expect(find.text('Program Studi'), findsOneWidget);
    expect(find.text('Semester (1-14)'), findsOneWidget);
    expect(find.text('Email Kampus'), findsOneWidget);
  });

  testWidgets('Tambah mahasiswa dan membuka detail',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah Mahasiswa'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);

    await tester.enterText(fields.at(0), 'Andi Pratama');
    await tester.enterText(fields.at(1), '2023004');
    await tester.enterText(fields.at(2), 'Sistem Informasi');
    await tester.enterText(fields.at(3), '5');
    await tester.enterText(fields.at(4), 'andi@gmail.com');

    await tester.ensureVisible(find.text('Simpan Baru'));
    await tester.tap(find.text('Simpan Baru'));
    await tester.pumpAndSettle();

    expect(find.text('Total: 4'), findsOneWidget);
    expect(find.text('Andi Pratama'), findsOneWidget);

    await tester.tap(find.text('Andi Pratama'));
    await tester.pumpAndSettle();

    expect(find.text('Detail Mahasiswa'), findsOneWidget);
    expect(find.text('2023004'), findsOneWidget);
    expect(find.text('Sistem Informasi'), findsOneWidget);
    expect(find.text('andi@gmail.com'), findsOneWidget);
  });

  testWidgets('Batal tidak menambahkan mahasiswa',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah Mahasiswa'));
    await tester.pumpAndSettle();

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Total: 3'), findsOneWidget);
  });

  testWidgets('NIM duplikat ditolak',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah Mahasiswa'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);

    await tester.enterText(fields.at(0), 'Mahasiswa Baru');
    await tester.enterText(fields.at(1), '2023001');
    await tester.enterText(fields.at(2), 'Sistem Informasi');
    await tester.enterText(fields.at(3), '5');
    await tester.enterText(fields.at(4), 'baru@gmail.com');

    await tester.ensureVisible(find.text('Simpan Baru'));
    await tester.tap(find.text('Simpan Baru'));
    await tester.pumpAndSettle();

   expect(find.text('NIM sudah terdaftar'), findsOneWidget);

// Kembali ke halaman dashboard
await tester.pageBack();
await tester.pumpAndSettle();

// Pastikan jumlah mahasiswa tetap 3
expect(find.text('Total: 3'), findsOneWidget);
  });

  test('validasiNimUnik menolak NIM yang sudah terdaftar', () {
    expect(
      AkademikService.validasiNimUnik(
        '2023001',
        ['2023001'],
      ),
      'NIM sudah terdaftar',
    );

    expect(
      AkademikService.validasiNimUnik(
        '2023004',
        ['2023001'],
      ),
      isNull,
    );
  });
}

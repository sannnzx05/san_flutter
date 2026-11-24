
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:san_flutter/main.dart';

void main() {
  testWidgets('Dashboard Akademik tampil dengan benar',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Dashboard Akademik'), findsOneWidget);
    expect(find.text('Profil Saya'), findsOneWidget);
    expect(find.text('Daftar Mahasiswa (3)'), findsOneWidget);

    expect(find.text('Rina Amelia'), findsOneWidget);
    expect(find.text('Budi Santoso'), findsOneWidget);
    expect(find.text('Siti Rahma'), findsOneWidget);

    expect(find.text('Tambah'), findsOneWidget);
  });

  testWidgets('Tombol Tambah membuka halaman form',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah'));
    await tester.pumpAndSettle();

    expect(find.text('Tambah Mahasiswa'), findsOneWidget);
    expect(find.text('Program Studi'), findsOneWidget);
  });

  testWidgets('Tambah mahasiswa dan membuka detail',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);

    await tester.enterText(fields.at(0), 'Andi Pratama');
    await tester.enterText(fields.at(1), '2023004');
    await tester.enterText(fields.at(2), 'Sistem Informasi');
    await tester.enterText(fields.at(3), 'andi@gmail.com');
    await tester.enterText(fields.at(4), '5');

    await tester.ensureVisible(find.text('Simpan'));
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    expect(find.text('Daftar Mahasiswa (4)'), findsOneWidget);
    expect(find.text('Andi Pratama'), findsOneWidget);

    await tester.tap(find.text('Andi Pratama'));
    await tester.pumpAndSettle();

    expect(find.text('2023004'), findsOneWidget);
    expect(find.text('Sistem Informasi'), findsOneWidget);
    expect(find.text('andi@gmail.com'), findsOneWidget);
  });

  testWidgets('Batal tidak menambahkan mahasiswa',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Batal'));
    await tester.pumpAndSettle();

    expect(find.text('Daftar Mahasiswa (3)'), findsOneWidget);
  });

  testWidgets('NIM duplikat ditolak',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);

    await tester.enterText(fields.at(0), 'Mahasiswa Baru');
    await tester.enterText(fields.at(1), '2023001');
    await tester.enterText(fields.at(2), 'Sistem Informasi');
    await tester.enterText(fields.at(3), 'baru@gmail.com');
    await tester.enterText(fields.at(4), '5');

    await tester.ensureVisible(find.text('Simpan'));
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    expect(find.text('NIM sudah terdaftar'), findsOneWidget);
    expect(find.text('Daftar Mahasiswa (3)'), findsNothing);
  });
  test('validasiNimUnik menolak NIM yang sudah terdaftar', () {
  expect(
    validasiNimUnik('2023001', ['2023001']),
    'NIM sudah terdaftar',
  );

  expect(
    validasiNimUnik('2023004', ['2023001']),
    isNull,
  );
});
}

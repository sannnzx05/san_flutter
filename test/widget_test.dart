
import 'package:flutter_test/flutter_test.dart';
import 'package:san_flutter/main.dart';

void main() {
  testWidgets('Dashboard Akademik tampil dengan benar',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Dashboard Akademik'), findsOneWidget);
    expect(find.text('Profil Saya'), findsOneWidget);
    expect(find.text('Daftar Mahasiswa'), findsOneWidget);

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
  });
}

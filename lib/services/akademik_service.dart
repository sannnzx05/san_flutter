
import '../models/mahasiswa.dart';
import '../models/mata_kuliah.dart';

class AkademikService {
  static List<Mahasiswa> ambilDataAwalMahasiswa() {
    return [
      const Mahasiswa(
        id: 'M001',
        nim: '2023001',
        nama: 'Rina Amelia',
        prodi: 'Sistem Informasi',
        semester: 5,
        email: 'rina@uinjambi.ac.id',
      ),
      const Mahasiswa(
        id: 'M002',
        nim: '2023002',
        nama: 'Budi Santoso',
        prodi: 'Sistem Informasi',
        semester: 5,
        email: 'budi@uinjambi.ac.id',
      ),
      const Mahasiswa(
        id: 'M003',
        nim: '2024003',
        nama: 'Siti Rahma',
        prodi: 'Sistem Informasi',
        semester: 3,
        email: 'siti@uinjambi.ac.id',
      ),
    ];
  }

  static List<MataKuliah> ambilDataAwalMataKuliah() {
    return [
      const MataKuliah(
        id: 'MK01',
        kode: 'SIF65005',
        namaMk: 'Pemrograman Mobile',
        sks: 4,
        semester: 5,
      ),
      const MataKuliah(
        id: 'MK02',
        kode: 'SIF65002',
        namaMk: 'Rekayasa Perangkat Lunak',
        sks: 3,
        semester: 5,
      ),
    ];
  }

  static String? validasiNama(String? nilai) {
    final teks = nilai?.trim() ?? '';
    if (teks.isEmpty) return 'Nama wajib diisi';
    if (teks.length < 3) return 'Minimal 3 karakter';
    return null;
  }

  static String? validasiNim(String? nilai) {
    final teks = nilai?.trim() ?? '';
    if (teks.isEmpty) return 'NIM wajib diisi';
    if (!RegExp(r'^[0-9]+$').hasMatch(teks)) {
      return 'NIM hanya boleh angka';
    }
    if (teks.length < 7) return 'NIM minimal 7 digit';
    return null;
  }

  static String? validasiEmail(String? nilai) {
    final teks = nilai?.trim() ?? '';
    if (teks.isEmpty) return 'Email wajib diisi';

    final pola = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');

    if (!pola.hasMatch(teks)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  static String? validasiSemester(String? nilai) {
    final angka = int.tryParse(nilai?.trim() ?? '');
    if (angka == null || angka < 1 || angka > 14) {
      return 'Semester harus angka 1 sampai 14';
    }
    return null;
  }
  static String? validasiNimUnik(
  String? nilai,
  List<String> daftarNim,
) {
  final teks = nilai?.trim() ?? '';

  if (daftarNim.contains(teks)) {
    return 'NIM sudah terdaftar';
  }

  return null;
}
}

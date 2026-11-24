
import 'package:flutter/material.dart';

import '../models/mahasiswa.dart';
import '../models/mata_kuliah.dart';
import '../services/akademik_service.dart';
import '../widgets/kartu_mahasiswa.dart';
import 'form_mahasiswa_screen.dart';
import 'detail_mahasiswa_screen.dart';
import 'form_mata_kuliah_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late List<Mahasiswa> _daftarMahasiswa;
  late List<MataKuliah> _daftarMataKuliah;

  @override
  void initState() {
    super.initState();

    _daftarMahasiswa =
        List.of(AkademikService.ambilDataAwalMahasiswa());

    _daftarMataKuliah =
        List.of(AkademikService.ambilDataAwalMataKuliah());
  }

  // CREATE dan UPDATE MAHASISWA
  Future<void> _bukaFormMahasiswa({
    Mahasiswa? mhsEdit,
  }) async {
    final hasil = await Navigator.push<Mahasiswa>(
      context,
      MaterialPageRoute(
        builder: (context) => FormMahasiswaScreen(
  mahasiswaEdit: mhsEdit,
  daftarMahasiswa: _daftarMahasiswa,
),
      ),
    );

    if (!mounted) return;

    if (hasil != null) {
      setState(() {
        if (mhsEdit == null) {
          _daftarMahasiswa.add(hasil);
        } else {
          final idx = _daftarMahasiswa.indexWhere(
            (m) => m.id == hasil.id,
          );

          if (idx != -1) {
            _daftarMahasiswa[idx] = hasil;
          }
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            mhsEdit == null
                ? '${hasil.nama} berhasil ditambahkan'
                : '${hasil.nama} berhasil diperbarui',
          ),
        ),
      );
    }
  }

  // DELETE MAHASISWA
  Future<void> _konfirmasiHapusMahasiswa(
    Mahasiswa mhs,
  ) async {
    final yakin = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Mahasiswa?'),
        content: Text(
          'Yakin ingin menghapus "${mhs.nama}" '
          '(NIM: ${mhs.nim})?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (!mounted) return;

    if (yakin == true) {
      setState(() {
        _daftarMahasiswa.removeWhere(
          (item) => item.id == mhs.id,
        );
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${mhs.nama} berhasil dihapus'),
        ),
      );
    }
  }

  // READ DETAIL MAHASISWA
  void _bukaDetailMahasiswa(Mahasiswa mhs) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailMahasiswaScreen(
          mahasiswa: mhs,
        ),
      ),
    );
  }

  // CREATE dan UPDATE MATA KULIAH
  Future<void> _bukaFormMataKuliah({
    MataKuliah? mkEdit,
  }) async {
    final hasil = await Navigator.push<MataKuliah>(
      context,
      MaterialPageRoute(
        builder: (context) => FormMataKuliahScreen(
          mataKuliahEdit: mkEdit,
        ),
      ),
    );

    if (!mounted) return;

    if (hasil != null) {
      setState(() {
        if (mkEdit == null) {
          _daftarMataKuliah.add(hasil);
        } else {
          final idx = _daftarMataKuliah.indexWhere(
            (mk) => mk.id == hasil.id,
          );

          if (idx != -1) {
            _daftarMataKuliah[idx] = hasil;
          }
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            mkEdit == null
                ? '${hasil.namaMk} berhasil ditambahkan'
                : '${hasil.namaMk} berhasil diperbarui',
          ),
        ),
      );
    }
  }

  // DELETE MATA KULIAH
  Future<void> _konfirmasiHapusMataKuliah(
    MataKuliah mk,
  ) async {
    final yakin = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Mata Kuliah?'),
        content: Text(
          'Yakin ingin menghapus "${mk.namaMk}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (!mounted) return;

    if (yakin == true) {
      setState(() {
        _daftarMataKuliah.removeWhere(
          (item) => item.id == mk.id,
        );
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${mk.namaMk} berhasil dihapus'),
        ),
      );
    }
  }

  // TAMPILAN TAB MAHASISWA
  Widget _buildTabMahasiswa() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Daftar Mahasiswa',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Total: ${_daftarMahasiswa.length}',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Expanded(
            child: _daftarMahasiswa.isEmpty
                ? const Center(
                    child: Text('Belum ada data mahasiswa'),
                  )
                : ListView.builder(
                    itemCount: _daftarMahasiswa.length,
                    itemBuilder: (context, index) {
                      final mhs = _daftarMahasiswa[index];

                      return KartuMahasiswa(
                        mahasiswa: mhs,
                        onTap: () =>
                            _bukaDetailMahasiswa(mhs),
                        onEdit: () =>
                            _bukaFormMahasiswa(mhsEdit: mhs),
                        onDelete: () =>
                            _konfirmasiHapusMahasiswa(mhs),
                      );
                    },
                  ),
          ),

          const SizedBox(height: 12),

          FilledButton.icon(
            onPressed: () => _bukaFormMahasiswa(),
            icon: const Icon(Icons.person_add),
            label: const Text('Tambah Mahasiswa'),
          ),
        ],
      ),
    );
  }

  // TAMPILAN TAB MATA KULIAH
  Widget _buildTabMataKuliah() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Daftar Mata Kuliah',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Total: ${_daftarMataKuliah.length}',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Expanded(
            child: _daftarMataKuliah.isEmpty
                ? const Center(
                    child: Text('Belum ada data mata kuliah'),
                  )
                : ListView.builder(
                    itemCount: _daftarMataKuliah.length,
                    itemBuilder: (context, index) {
                      final mk = _daftarMataKuliah[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.menu_book),
                          ),
                          title: Text(
                            mk.namaMk,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Kode: ${mk.kode}\n'
                            '${mk.sks} SKS • Semester ${mk.semester}',
                          ),
                          isThreeLine: true,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                tooltip: 'Edit',
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () =>
                                    _bukaFormMataKuliah(mkEdit: mk),
                              ),
                              IconButton(
                                tooltip: 'Hapus',
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () =>
                                    _konfirmasiHapusMataKuliah(mk),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          const SizedBox(height: 12),

          FilledButton.icon(
            onPressed: () => _bukaFormMataKuliah(),
            icon: const Icon(Icons.add),
            label: const Text('Tambah Mata Kuliah'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard Akademik'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.people),
                text: 'Mahasiswa',
              ),
              Tab(
                icon: Icon(Icons.menu_book),
                text: 'Mata Kuliah',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTabMahasiswa(),
            _buildTabMataKuliah(),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/mahasiswa.dart';
import '../services/akademik_service.dart';

class FormMahasiswaScreen extends StatefulWidget {
  final Mahasiswa? mahasiswaEdit;
  final List<Mahasiswa> daftarMahasiswa;

  const FormMahasiswaScreen({
    super.key,
    this.mahasiswaEdit,
    required this.daftarMahasiswa,
  });

  @override
  State<FormMahasiswaScreen> createState() =>
      _FormMahasiswaScreenState();
}

class _FormMahasiswaScreenState
    extends State<FormMahasiswaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaCtrl = TextEditingController();
  final _nimCtrl = TextEditingController();
  final _prodiCtrl = TextEditingController();
  final _semCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  bool get _isEdit => widget.mahasiswaEdit != null;

  @override
  void initState() {
    super.initState();

    if (_isEdit) {
      final m = widget.mahasiswaEdit!;
      _namaCtrl.text = m.nama;
      _nimCtrl.text = m.nim;
      _prodiCtrl.text = m.prodi;
      _semCtrl.text = m.semester.toString();
      _emailCtrl.text = m.email;
    } else {
      _prodiCtrl.text = 'Sistem Informasi';
    }
  }

  @override
  void dispose() {
    _namaCtrl.dispose();
    _nimCtrl.dispose();
    _prodiCtrl.dispose();
    _semCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  String? _validasiNimUnik(String? nilai) {
    final validasiDasar =
        AkademikService.validasiNim(nilai);

    if (validasiDasar != null) {
      return validasiDasar;
    }

    final daftarNim = widget.daftarMahasiswa
        .where((m) => !_isEdit ||
            m.id != widget.mahasiswaEdit!.id)
        .map((m) => m.nim)
        .toList();

    return AkademikService.validasiNimUnik(
      nilai,
      daftarNim,
    );
  }

  void _simpan() {
    if (_formKey.currentState!.validate()) {
      final hasil = Mahasiswa(
        id: _isEdit
            ? widget.mahasiswaEdit!.id
            : 'M${DateTime.now().millisecondsSinceEpoch}',
        nama: _namaCtrl.text.trim(),
        nim: _nimCtrl.text.trim(),
        prodi: _prodiCtrl.text.trim(),
        semester: int.parse(_semCtrl.text.trim()),
        email: _emailCtrl.text.trim(),
      );

      Navigator.pop(context, hasil);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEdit ? 'Edit Mahasiswa' : 'Tambah Mahasiswa',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _namaCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                ),
                validator: AkademikService.validasiNama,
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _nimCtrl,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: 'NIM',
                  border: OutlineInputBorder(),
                ),
                validator: _validasiNimUnik,
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _prodiCtrl,
                decoration: const InputDecoration(
                  labelText: 'Program Studi',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _semCtrl,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: 'Semester (1-14)',
                  border: OutlineInputBorder(),
                ),
                validator: AkademikService.validasiSemester,
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Kampus',
                  border: OutlineInputBorder(),
                ),
                validator: AkademikService.validasiEmail,
              ),
              const SizedBox(height: 20),

              FilledButton.icon(
                onPressed: _simpan,
                icon: const Icon(Icons.save),
                label: Text(
                  _isEdit ? 'Simpan Perubahan' : 'Simpan Baru',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/mata_kuliah.dart';

class FormMataKuliahScreen extends StatefulWidget {
  final MataKuliah? mataKuliahEdit;

  const FormMataKuliahScreen({
    super.key,
    this.mataKuliahEdit,
  });

  @override
  State<FormMataKuliahScreen> createState() =>
      _FormMataKuliahScreenState();
}

class _FormMataKuliahScreenState
    extends State<FormMataKuliahScreen> {
  final _formKey = GlobalKey<FormState>();

  final _kodeCtrl = TextEditingController();
  final _namaCtrl = TextEditingController();
  final _sksCtrl = TextEditingController();
  final _semesterCtrl = TextEditingController();

  bool get _isEdit => widget.mataKuliahEdit != null;

  @override
  void initState() {
    super.initState();

    if (_isEdit) {
      final mk = widget.mataKuliahEdit!;
      _kodeCtrl.text = mk.kode;
      _namaCtrl.text = mk.namaMk;
      _sksCtrl.text = mk.sks.toString();
      _semesterCtrl.text = mk.semester.toString();
    }
  }

  @override
  void dispose() {
    _kodeCtrl.dispose();
    _namaCtrl.dispose();
    _sksCtrl.dispose();
    _semesterCtrl.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    final hasil = MataKuliah(
      id: _isEdit
          ? widget.mataKuliahEdit!.id
          : 'MK${DateTime.now().millisecondsSinceEpoch}',
      kode: _kodeCtrl.text.trim(),
      namaMk: _namaCtrl.text.trim(),
      sks: int.parse(_sksCtrl.text.trim()),
      semester: int.parse(_semesterCtrl.text.trim()),
    );

    Navigator.pop(context, hasil);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEdit ? 'Edit Mata Kuliah' : 'Tambah Mata Kuliah',
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
                controller: _kodeCtrl,
                decoration: const InputDecoration(
                  labelText: 'Kode Mata Kuliah',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Kode mata kuliah wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _namaCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nama Mata Kuliah',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama mata kuliah wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _sksCtrl,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: 'Jumlah SKS',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final sks = int.tryParse(value ?? '');

                  if (sks == null || sks < 1 || sks > 6) {
                    return 'SKS harus antara 1 sampai 6';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _semesterCtrl,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: 'Semester (1-14)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final semester = int.tryParse(value ?? '');

                  if (semester == null ||
                      semester < 1 ||
                      semester > 14) {
                    return 'Semester harus antara 1 sampai 14';
                  }
                  return null;
                },
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

// Pertemuan 5 - Form tambah data mahasiswa dengan validasi (Tugas 4)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Akademik Mahasiswa',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal)),
      home: const DashboardPage(),
    );
  }
}

const List<Map<String, String>> daftarMahasiswa = [
  {'nama': 'Rina Amelia', 'nim': '2023001', 'prodi': 'Sistem Informasi', 'semester': '5', 'email': 'rina@contoh.ac.id'},
  {'nama': 'Budi Santoso', 'nim': '2023002', 'prodi': 'Sistem Informasi', 'semester': '5', 'email': 'budi@contoh.ac.id'},
  {'nama': 'Siti Rahma', 'nim': '2023003', 'prodi': 'Sistem Informasi', 'semester': '3', 'email': 'siti@contoh.ac.id'},
];


class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late List<Map<String, String>> _daftar;

  @override
  void initState() {
    super.initState();
    _daftar = List.of(daftarMahasiswa);
  }
Future<void> _bukaFormTambah() async {
  final hasil = await Navigator.push<Map<String, String>>(
    context,
    MaterialPageRoute(
      builder: (_) => TambahMahasiswaPage(
        nimTerdaftar: _daftar
            .map((mhs) => mhs['nim']!)
            .toList(),
      ),
    ),
  );

  if (!mounted) return;
  if (hasil == null) return;

  setState(() {
    _daftar.add(hasil);
  });

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('${hasil['nama']} berhasil ditambahkan.'),
    ),
  );
}
void _bukaDetail(Map<String, String> mhs) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => DetailMahasiswaPage(
        mahasiswa: mhs,
      ),
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Akademik'),
        backgroundColor: warna.primaryContainer,
      ),
      floatingActionButton: FloatingActionButton.extended(
  onPressed: _bukaFormTambah,
  icon: const Icon(Icons.person_add),
  label: const Text('Tambah'),
),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profil Saya'),
              subtitle: const Text('Identitas dan keahlian'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfilPage(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Daftar Mahasiswa (${_daftar.length})',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
         for (final mhs in _daftar)
  KartuMahasiswa(
    mahasiswa: mhs,
    onTap: () => _bukaDetail(mhs),
  ),
      
        ],
      ),
    );
  }
}


String? validasiNama(String? val) {
  final t = val?.trim() ?? '';
  if (t.isEmpty) return 'Nama wajib diisi';
  if (t.length < 3) return 'Nama minimal 3 huruf';
  return null;
}
String? validasiNim(String? val) {
  final t = val?.trim() ?? '';
  if (t.isEmpty) return 'NIM wajib diisi';
  if (!RegExp(r'^[0-9]+$').hasMatch(t)) return 'NIM hanya boleh berisi angka';
  if (t.length < 7) return 'NIM minimal 7 digit';
  return null;
}
String? validasiEmail(String? val) {
  final t = val?.trim() ?? '';
  if (t.isEmpty) return 'Email wajib diisi';
  if (!RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$').hasMatch(t)) return 'Format email tidak valid (contoh: nama@kampus.ac.id)';
  return null;
}
String? validasiSemester(String? val) {
  final t = val?.trim() ?? '';
  if (t.isEmpty) return 'Semester wajib diisi';
  final a = int.tryParse(t);
  if (a == null) return 'Semester harus berupa angka';
  if (a < 1 || a > 14) return 'Semester harus antara 1 dan 14';
  return null;
}
String? validasiNimUnik(
  String? val,
  List<String> nimTerdaftar,
) {
  final hasil = validasiNim(val);

  if (hasil != null) return hasil;

  if (nimTerdaftar.contains(val!.trim())) {
    return 'NIM sudah terdaftar';
  }

  return null;
}
class KartuMahasiswa extends StatelessWidget {
  final Map<String, String> mahasiswa;
  final VoidCallback onTap;

  const KartuMahasiswa({
    super.key,
    required this.mahasiswa,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(mahasiswa['nama']![0]),
        ),
        title: Text(mahasiswa['nama']!),
        subtitle: Text('NIM ${mahasiswa['nim']}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
class KolomTeks extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData ikon;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final void Function(String)? onFieldSubmitted;

  const KolomTeks({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.ikon,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters,
    this.maxLength,
    this.focusNode,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      textCapitalization: textCapitalization,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(ikon),
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
class TambahMahasiswaPage extends StatefulWidget {
  const TambahMahasiswaPage({
    super.key,
    required this.nimTerdaftar,
  });

final List<String> nimTerdaftar;

@override
State<TambahMahasiswaPage> createState() =>
    _TambahMahasiswaPageState();
}

class _TambahMahasiswaPageState extends State<TambahMahasiswaPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaC = TextEditingController();
  final _nimC = TextEditingController();
  final _emailC = TextEditingController();
  final _semC = TextEditingController();
  final _namaF = FocusNode();
  final _prodiC = TextEditingController();
  AutovalidateMode _mode = AutovalidateMode.disabled;
  Map<String, String>? _hasil;

  @override
  @override
void dispose() {
  _namaC.dispose();
  _nimC.dispose();
  _prodiC.dispose();
  _emailC.dispose();
  _semC.dispose();
  _namaF.dispose();
  super.dispose();
}
 void _simpan() {
  FocusScope.of(context).unfocus();

  if (_formKey.currentState!.validate()) {
    final Map<String, String> dataBaru = {
      'nama': _namaC.text.trim(),
      'nim': _nimC.text.trim(),
      'prodi': _prodiC.text.trim(),
      'email': _emailC.text.trim(),
      'semester': _semC.text.trim(),
    };

    Navigator.pop(context, dataBaru);
  } else {
    setState(() {
      _mode = AutovalidateMode.onUserInteraction;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Periksa kembali isian yang ditandai merah.'),
      ),
    );
  }
}

  void _kosongkan() {
    _formKey.currentState!.reset();
    _namaC.clear(); _nimC.clear(); _emailC.clear(); _semC.clear();
    setState(() { _hasil = null; _mode = AutovalidateMode.disabled; });
    _namaF.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Mahasiswa')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey, autovalidateMode: _mode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              KolomTeks(
  controller: _namaC,
  focusNode: _namaF,
  autofocus: true,
  label: 'Nama lengkap',
  hint: 'mis. Rina Amelia',
  ikon: Icons.person,
  validator: validasiNama,
  textCapitalization: TextCapitalization.words,
),
              KolomTeks(
  controller: _nimC,
  label: 'NIM',
  hint: 'hanya angka',
  ikon: Icons.badge,
  keyboardType: TextInputType.number,
  textInputAction: TextInputAction.next,
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
  ],
  maxLength: 12,
  validator: (val) =>
      validasiNimUnik(val, widget.nimTerdaftar),
),
KolomTeks(
  controller: _prodiC,
  label: 'Program Studi',
  hint: 'mis. Sistem Informasi',
  ikon: Icons.school,
  textCapitalization: TextCapitalization.words,
  validator: (val) {
    if (val == null || val.trim().isEmpty) {
      return 'Program Studi wajib diisi';
    }
    return null;
  },
),
             KolomTeks(
  controller: _emailC,
  label: 'Email',
  hint: 'nama@kampus.ac.id',
  ikon: Icons.email,
  keyboardType: TextInputType.emailAddress,
  textInputAction: TextInputAction.next,
  validator: validasiEmail,
),
              KolomTeks(
  controller: _semC,
  label: 'Semester',
  hint: '1 sampai 14',
  ikon: Icons.school,
  keyboardType: TextInputType.number,
  textInputAction: TextInputAction.done,
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
  ],
  maxLength: 2,
  validator: validasiSemester,
  onFieldSubmitted: (_) => _simpan(),
),
              FilledButton.icon(onPressed: _simpan, icon: const Icon(Icons.save), label: const Text('Simpan')),
              const SizedBox(height: 8),
              const SizedBox(height: 8),
OutlinedButton.icon(
  onPressed: () {
    Navigator.pop(context);
  },
  icon: const Icon(Icons.cancel),
  label: const Text('Batal'),
),
              OutlinedButton.icon(onPressed: _kosongkan, icon: const Icon(Icons.refresh), label: const Text('Kosongkan')),
              if (_hasil != null) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer, borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Pratinjau data valid', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      BarisInfo(label: 'Nama', nilai: _hasil!['nama']!),
                      BarisInfo(label: 'NIM', nilai: _hasil!['nim']!),
                      BarisInfo(label: 'Email', nilai: _hasil!['email']!),
                      BarisInfo(label: 'Semester', nilai: _hasil!['semester']!),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class DetailMahasiswaPage extends StatelessWidget {
  const DetailMahasiswaPage({super.key, required this.mahasiswa});
  final Map<String, String> mahasiswa;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Mahasiswa')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BarisInfo(label: 'Nama', nilai: mahasiswa['nama'] ?? '-'),
            BarisInfo(label: 'NIM', nilai: mahasiswa['nim'] ?? '-'),
            BarisInfo(label: 'Program Studi', nilai: mahasiswa['prodi'] ?? '-'),
            BarisInfo(label: 'Semester', nilai: mahasiswa['semester'] ?? '-'),
            BarisInfo(label: 'Email', nilai: mahasiswa['email'] ?? '-'),
            const SizedBox(height: 24),
            FilledButton.icon(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back), label: const Text('Kembali ke Dashboard')),
          ],
        ),
      ),
    );
  }
}

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});
  static const Map<String, String> profil = {'Nama': 'Rina Amelia', 'NIM': '2023001', 'Program Studi': 'Sistem Informasi', 'Semester': '5', 'Email': 'rina@contoh.ac.id'};
  static const List<String> keahlian = ['Flutter', 'Basis Data', 'Desain UI'];
  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Mahasiswa'), backgroundColor: warna.primaryContainer),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: warna.primaryContainer, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
                  const SizedBox(width: 16),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(profil['Nama']!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4), Text('${profil['NIM']} · ${profil['Program Studi']}'),
                  ])),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Identitas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            for (final d in profil.entries) BarisInfo(label: d.key, nilai: d.value),
            const SizedBox(height: 24),
            const Text('Keahlian', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            for (final i in keahlian) Row(children: [Icon(Icons.check_circle, color: warna.primary), const SizedBox(width: 8), Text(i)]),
          ],
        ),
      ),
    );
  }
}

class BarisInfo extends StatelessWidget {
  const BarisInfo({super.key, required this.label, required this.nilai});
  final String label;
  final String nilai;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 120, child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
          const Text(': '),
          Expanded(child: Text(nilai)),
        ],
      ),
    );
  }
}
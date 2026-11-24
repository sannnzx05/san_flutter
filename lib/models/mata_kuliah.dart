
class MataKuliah {
  final String id;
  final String kode;
  final String namaMk;
  final int sks;
  final int semester;

  const MataKuliah({
    required this.id,
    required this.kode,
    required this.namaMk,
    required this.sks,
    required this.semester,
  });

  MataKuliah copyWith({
    String? id,
    String? kode,
    String? namaMk,
    int? sks,
    int? semester,
  }) {
    return MataKuliah(
      id: id ?? this.id,
      kode: kode ?? this.kode,
      namaMk: namaMk ?? this.namaMk,
      sks: sks ?? this.sks,
      semester: semester ?? this.semester,
    );
  }

  factory MataKuliah.fromMap(Map<String, dynamic> map) {
    return MataKuliah(
      id: map['id']?.toString() ?? '',
      kode: map['kode']?.toString() ?? '',
      namaMk: map['namaMk']?.toString() ?? '',
      sks: int.tryParse(map['sks']?.toString() ?? '') ?? 2,
      semester: int.tryParse(
            map['semester']?.toString() ?? '',
          ) ??
          1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kode': kode,
      'namaMk': namaMk,
      'sks': sks,
      'semester': semester,
    };
  }
}

class Karyawan {
  final String id;
  final String nama;
  final String tglMasuk;
  final int usia;

  Karyawan({
    required this.id,
    required this.nama,
    required this.tglMasuk,
    required this.usia,
  });

  factory Karyawan.fromMap(Map<String, dynamic> map) {
    return Karyawan(
      id: map['id'],
      nama: map['nama'],
      tglMasuk: map['tglMasuk'],
      usia: map['usia'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'nama': nama, 'tglMasuk': tglMasuk, 'usia': usia};
  }
}

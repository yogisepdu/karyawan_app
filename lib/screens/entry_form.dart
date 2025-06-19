import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/karyawan.dart';
import '../db/database_helper.dart';

class EntryForm extends StatefulWidget {
  final Karyawan? data;

  const EntryForm({super.key, this.data});

  @override
  _EntryFormState createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _namaController = TextEditingController();
  final _tglMasukController = TextEditingController();
  final _usiaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      _idController.text = widget.data!.id;
      _namaController.text = widget.data!.nama;
      _tglMasukController.text = widget.data!.tglMasuk;
      _usiaController.text = widget.data!.usia.toString();
    }
  }

  Future<void> _pilihTanggal() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.data != null
          ? DateTime.parse(widget.data!.tglMasuk)
          : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      _tglMasukController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  void _simpanData() async {
    if (_formKey.currentState!.validate()) {
      final karyawan = Karyawan(
        id: _idController.text.trim(),
        nama: _namaController.text.trim(),
        tglMasuk: _tglMasukController.text.trim(),
        usia: int.parse(_usiaController.text.trim()),
      );

      await DatabaseHelper.instance.saveKaryawan(karyawan);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data != null ? 'Edit Karyawan' : 'Tambah Karyawan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'ID Karyawan'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: _tglMasukController,
                decoration: InputDecoration(labelText: 'Tanggal Masuk'),
                readOnly: true,
                onTap: _pilihTanggal,
              ),
              TextFormField(
                controller: _usiaController,
                decoration: InputDecoration(labelText: 'Usia'),
                keyboardType: TextInputType.number,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Wajib diisi' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _simpanData, child: Text('SIMPAN')),
            ],
          ),
        ),
      ),
    );
  }
}

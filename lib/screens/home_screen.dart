import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/database_helper.dart';
import '../models/karyawan.dart';
import 'entry_form.dart';
import 'github_api_screen.dart';
import '../widgets/karyawan_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _namaController = TextEditingController();
  final _tglAwalController = TextEditingController();
  final _tglAkhirController = TextEditingController();

  List<Karyawan> _karyawanList = [];

  @override
  void initState() {
    super.initState();
    _loadKaryawan();
  }

  Future<void> _loadKaryawan() async {
    final nama = _namaController.text;
    final tglAwal = _tglAwalController.text;
    final tglAkhir = _tglAkhirController.text;
    final data = await DatabaseHelper.instance.getFilteredKaryawan(
      nama: nama,
      tglAwal: tglAwal,
      tglAkhir: tglAkhir,
    );
    setState(() {
      _karyawanList = data;
    });
  }

  Future<void> _hapusData(String id) async {
    await DatabaseHelper.instance.deleteKaryawan(id);
    _loadKaryawan();
  }

  void _bukaForm({Karyawan? data}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EntryForm(data: data)),
    );
    if (result == true) {
      _loadKaryawan();
    }
  }

  void _bukaApiScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => GitHubApiScreen()),
    );
  }

  Future<void> _pilihTanggal(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Karyawan'),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _loadKaryawan),
        ],
      ),
      body: Column(
        children: [
          // FILTER FORM
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _namaController,
                  decoration: InputDecoration(labelText: 'Nama Karyawan'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _tglAwalController,
                        readOnly: true,
                        onTap: () => _pilihTanggal(_tglAwalController),
                        decoration: InputDecoration(
                          labelText: 'Tgl Masuk Dari',
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _tglAkhirController,
                        readOnly: true,
                        onTap: () => _pilihTanggal(_tglAkhirController),
                        decoration: InputDecoration(
                          labelText: 'Sampai Tanggal',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: _loadKaryawan,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          // DATA LIST
          Expanded(
            child: KaryawanList(
              data: _karyawanList,
              onEdit: (k) => _bukaForm(data: k),
              onDelete: _hapusData,
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'new',
            onPressed: () => _bukaForm(),
            tooltip: 'New',
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'api',
            onPressed: _bukaApiScreen,
            tooltip: 'API View',
            child: Icon(Icons.public),
            backgroundColor: Colors.blueGrey,
          ),
        ],
      ),
    );
  }
}

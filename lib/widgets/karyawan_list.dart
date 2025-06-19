import 'package:flutter/material.dart';
import '../models/karyawan.dart';

class KaryawanList extends StatelessWidget {
  final List<Karyawan> data;
  final Function(Karyawan) onEdit;
  final Function(String) onDelete;

  const KaryawanList({
    super.key,
    required this.data,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(child: Text('Data kosong.'));
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final k = data[index];
        return ListTile(
          title: Text('${k.nama} (${k.usia} thn)'),
          subtitle: Text('ID: ${k.id} | Masuk: ${k.tglMasuk}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.orange),
                onPressed: () => onEdit(k),
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => onDelete(k.id),
              ),
            ],
          ),
        );
      },
    );
  }
}

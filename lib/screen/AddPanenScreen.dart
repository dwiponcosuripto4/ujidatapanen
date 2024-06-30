import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ujidatapanen/controller/AddPanenController.dart';
import 'package:ujidatapanen/model/panen.dart';
import 'package:ujidatapanen/provider/AuthProvider.dart';

class AddPanenScreen extends StatefulWidget {
  final int idLahan;

  const AddPanenScreen({required this.idLahan, Key? key}) : super(key: key);

  @override
  _AddPanenScreenState createState() => _AddPanenScreenState();
}

class _AddPanenScreenState extends State<AddPanenScreen> {
  final PanenController _panenController = PanenController();
  TextEditingController noPanenController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController fotoController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController idLoadingController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    int userId = Provider.of<AuthProvider>(context, listen: false).userId ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Panen'),
        backgroundColor: const Color(0xFF1A4D2E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFF1A4D2E),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: noPanenController,
                decoration: const InputDecoration(
                  labelText: 'No Panen',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              TextFormField(
                controller: jumlahController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              TextFormField(
                controller: hargaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Harga',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              TextFormField(
                controller: fotoController,
                decoration: const InputDecoration(
                  labelText: 'Foto URL',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              TextFormField(
                controller: deskripsiController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              TextFormField(
                controller: idLoadingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'ID Loading',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'ID Lahan: ${widget.idLahan}',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String noPanen = noPanenController.text;
                  double jumlah = double.tryParse(jumlahController.text) ?? 0.0;
                  double harga = double.tryParse(hargaController.text) ?? 0.0;
                  String foto = fotoController.text;
                  String deskripsi = deskripsiController.text;
                  int idLoading = int.tryParse(idLoadingController.text) ?? 0;

                  Panen panen = Panen(
                    id: 0,
                    noPanen: noPanen,
                    tanggalPanen: selectedDate,
                    jumlah: jumlah,
                    harga: harga,
                    foto: foto,
                    deskripsi: deskripsi,
                    idLahan: widget.idLahan,
                    idLoading: idLoading,
                  );

                  bool createSuccess =
                      await _panenController.createPanen(context, panen);

                  if (createSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Panen berhasil ditambahkan'),
                        duration: Duration(seconds: 5),
                        backgroundColor: Colors.blue,
                      ),
                    );
                    Navigator.pop(context, true); // Kembali ke halaman sebelumnya
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Ubah warna tombol jika perlu
                  textStyle: const TextStyle(fontSize: 16),
                  fixedSize: const Size(200, 50), // Ubah ukuran tombol jika perlu
                ),
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

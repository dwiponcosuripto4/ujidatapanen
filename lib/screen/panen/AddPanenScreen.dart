import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ujidatapanen/controller/AddPanenController.dart';
import 'package:ujidatapanen/model/loading.dart';
import 'package:ujidatapanen/model/panen.dart';
import 'package:ujidatapanen/provider/AuthProvider.dart';
import 'package:ujidatapanen/service/loading/ViewLoadingService.dart';
import 'package:ujidatapanen/widget/TextInputField.dart';
import 'package:ujidatapanen/widget/ImagePickerButton.dart';
import 'package:ujidatapanen/widget/LoadingDropdown.dart';

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
  TextEditingController deskripsiController = TextEditingController();
  int selectedLoadingId = 0;
  List<Loading> loadingList = [];
  DateTime selectedDate = DateTime.now();
  File? imageFile;

  @override
  void initState() {
    super.initState();
    fetchLoadingData();
  }

  void fetchLoadingData() async {
    try {
      int userId = Provider.of<AuthProvider>(context, listen: false).userId ?? 0;
      List<Loading> data = await ViewLoadingService().fetchLoading(userId);
      setState(() {
        loadingList = data;
        if (loadingList.isNotEmpty) {
          selectedLoadingId = loadingList[0].id;
        }
      });
    } catch (e) {
      print('Error fetching loading data: $e');
    }
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Panen',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
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
              TextInputField(
                controller: noPanenController,
                labelText: 'No Panen',
              ),
              TextInputField(
                controller: jumlahController,
                labelText: 'Jumlah',
                keyboardType: TextInputType.number,
              ),
              TextInputField(
                controller: hargaController,
                labelText: 'Harga',
                keyboardType: TextInputType.number,
              ),
              ImagePickerButton(
                onImageSourceSelected: _getImage,
                imageFile: imageFile,
              ),
              TextInputField(
                controller: deskripsiController,
                labelText: 'Deskripsi',
              ),
              const SizedBox(height: 20),
              LoadingDropdown(
                selectedLoadingId: selectedLoadingId,
                loadingList: loadingList,
                onChanged: (int? value) {
                  setState(() {
                    selectedLoadingId = value ?? 0;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String noPanen = noPanenController.text;
                  double jumlah = double.tryParse(jumlahController.text) ?? 0.0;
                  double harga = double.tryParse(hargaController.text) ?? 0.0;
                  String deskripsi = deskripsiController.text;

                  Panen panen = Panen(
                    id: 0,
                    noPanen: noPanen,
                    tanggalPanen: selectedDate,
                    jumlah: jumlah,
                    harga: harga,
                    foto: imageFile != null ? imageFile!.path : '',
                    deskripsi: deskripsi,
                    idLahan: widget.idLahan,
                    idLoading: selectedLoadingId,
                  );

                  bool createSuccess = await _panenController.createPanen(
                    context,
                    panen,
                    imageFile: imageFile,
                  );

                  if (createSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Panen berhasil ditambahkan'),
                        duration: Duration(seconds: 5),
                        backgroundColor: Colors.blue,
                      ),
                    );
                    Navigator.pop(context, true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 16),
                  fixedSize: const Size(250, 50),
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

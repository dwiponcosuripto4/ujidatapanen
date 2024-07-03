// view_loading_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ujidatapanen/controller/EditLoadingController.dart';
import 'package:ujidatapanen/model/loading.dart';
import 'package:ujidatapanen/provider/AuthProvider.dart';
import 'package:ujidatapanen/screen/loading/ViewLoadingDetail.dart';
import 'package:ujidatapanen/screen/home.dart';
import 'package:ujidatapanen/screen/auth/login_screen.dart';
import 'package:ujidatapanen/screen/map/map_screen.dart';
import 'package:ujidatapanen/screen/profile/tentang_screen.dart';
import 'package:ujidatapanen/screen/loading/AddLoadingScreen.dart';
import 'package:ujidatapanen/service/loading/DeleteLoadingService.dart';
import 'package:ujidatapanen/service/loading/ViewLoadingService.dart';
import 'package:ujidatapanen/widget/search_loading.dart';
import 'package:ujidatapanen/widget/edit_dialog.dart';
import 'package:ujidatapanen/widget/delete_dialog.dart';

class ViewLoadingScreen extends StatefulWidget {
  @override
  _ViewLoadingScreenState createState() => _ViewLoadingScreenState();
}

class _ViewLoadingScreenState extends State<ViewLoadingScreen> {
  late Future<List<Loading>> _loadingFuture;
  String searchQuery = '';
  late int userId;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    userId = Provider.of<AuthProvider>(context, listen: false).userId ?? 0;
    _loadingFuture = ViewLoadingService().fetchLoading(userId);
  }

  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SearchDialog(
          onSearch: (value) {
            setState(() {
              searchQuery = value.toLowerCase();
            });
          },
        );
      },
    );
  }

  void showEditDialog(BuildContext context, Loading loading) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditDialog(
          loading: loading,
          onUpdate: fetchData,
        );
      },
    );
  }

  void showDeleteDialog(BuildContext context, Loading loading) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(
          namaLoading: loading.namaLoading,
          onDelete: () => deleteLoading(context, loading.id),
        );
      },
    );
  }

  void deleteLoading(BuildContext context, int id) async {
    try {
      bool deleteSuccess = await DeleteLoadingService().deleteLoading(id);
      if (deleteSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Berhasil menghapus loading'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          fetchData();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menghapus loading'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      String errorMessage = 'Terjadi kesalahan: $e';
      if (e.toString().contains('Loading sedang digunakan!')) {
        errorMessage = 'Loading sedang digunakan!';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void refreshData() {
    setState(() {
      _loadingFuture = ViewLoadingService().fetchLoading(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1A4D2E),
        title: Text(
          'Loading',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context); // Navigasi kembali normal
          },
        ),
      ),
      backgroundColor: Color(0xFF1A4D2E),
      body: FutureBuilder<List<Loading>>(
        future: _loadingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          } else {
            final loadingList = snapshot.data!;
            final filteredLoadingList = loadingList.where((loading) {
              return loading.namaLoading.toLowerCase().contains(searchQuery);
            }).toList();

            return ListView.builder(
              itemCount: filteredLoadingList.length,
              itemBuilder: (context, index) {
                final loading = filteredLoadingList[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                  child: Card(
                    color: Colors.white.withOpacity(0.10),
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        loading.namaLoading,
                        style: TextStyle(color: Colors.white),
                        maxLines: 1, // Atur jumlah maksimal baris teks
                        overflow: TextOverflow.ellipsis, // Penanganan overflow
                      ),
                      subtitle: Text(
                        loading.lokasi,
                        style: TextStyle(color: Colors.white),
                        maxLines: 1, // Atur jumlah maksimal baris teks
                        overflow: TextOverflow.ellipsis, // Penanganan overflow
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewLoadingDetail(
                              loading: loading,
                              userId: userId,
                            ),
                          ),
                        );
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            color: Color.fromARGB(255, 248, 248, 249),
                            onPressed: () {
                              showEditDialog(context, loading);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: Color.fromARGB(255, 248, 248, 249),
                            onPressed: () {
                              showDeleteDialog(context, loading);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Color(0xFF059212),
        child: Container(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeView(userId: userId),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearchDialog(context);
                },
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.list),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewLoadingScreen()),
                  );
                },
              ),
              PopupMenuButton<String>(
                icon: Icon(
                    Icons.person), // Menentukan ikon yang ingin ditampilkan
                onSelected: (value) {
                  switch (value) {
                    case 'Tentang':
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TentangView()),
                      );
                      break;
                    case 'Logout':
                      Provider.of<AuthProvider>(context, listen: false)
                          .clearUser();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                      break;
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: 'Tentang',
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 15,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Tentang',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'Logout',
                      child: Row(
                        children: [
                          Icon(
                            Icons.exit_to_app,
                            size: 15,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddLoadingScreen()),
          ).then((value) {
            if (value != null && value) {
              refreshData();
            }
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 191, 200, 205),
        shape: CircleBorder(),
        elevation: 8.0,
      ),
    );
  }
}

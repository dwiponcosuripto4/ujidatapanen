import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ujidatapanen/model/lahan.dart';
import 'package:ujidatapanen/provider/AuthProvider.dart';
import 'package:ujidatapanen/screen/auth/login_screen.dart';
import 'package:ujidatapanen/screen/lahan/AddLahanScreen.dart';
import 'package:ujidatapanen/screen/loading/ViewLoadingScreen.dart';
import 'package:ujidatapanen/screen/profile/tentang_screen.dart';
import 'package:ujidatapanen/service/lahan/DeleteLahanService.dart';
import 'package:ujidatapanen/service/lahan/ViewLahanService.dart';
import 'package:ujidatapanen/service/saldo/ViewSaldoService.dart';
import 'package:ujidatapanen/widget/Edit_Lahan_Diaolog.dart';
import 'package:ujidatapanen/widget/lahan_list_item.dart';
import 'package:ujidatapanen/widget/saldo_display.dart';
import 'package:ujidatapanen/widget/search_lahan.dart';

class HomeView extends StatefulWidget {
  final int userId;

  HomeView({required this.userId});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<Lahan>> _lahanFuture;
  late Future<Map<String, dynamic>> _saldoFuture;
  String searchQuery = '';
  bool _isPendapatanVisible = true;
  bool _isTotalPanenVisible = true;
  final LahanService _lahanService = LahanService();

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchSaldo();
  }

  void fetchData() {
    _lahanFuture = ViewLahanService().fetchLahan(widget.userId);
  }

  void fetchSaldo() {
    _saldoFuture = ViewSaldoService().getSaldo(widget.userId);
  }

  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SearchDialog(
          searchQuery: searchQuery,
          onChanged: (value) {
            setState(() {
              searchQuery = value.toLowerCase();
            });
          },
        );
      },
    );
  }

  Future<void> _deleteLahan(int id) async {
    try {
      await _lahanService.deleteLahan(id);
      setState(() {
        fetchData();
      });
    } catch (e) {
      print('Failed to delete lahan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF1A4D2E),
        title: Text(
          'Tani Jaya Company',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      backgroundColor: Color(0xFF1A4D2E),
      body: Column(
        children: [
          Center(
            child: Container(
              width: 325,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Material(
                elevation: 20,
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF059212),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<Map<String, dynamic>>(
                        future: _saldoFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData) {
                            return Text('Loading...');
                          } else {
                            double totalPanen =
                                (snapshot.data!['total_panen'] ?? 0).toDouble();
                            double pendapatan =
                                (snapshot.data!['pendapatan'] ?? 0).toDouble();

                            return SaldoDisplay(
                              totalPanen: totalPanen,
                              pendapatan: pendapatan,
                              isTotalPanenVisible: _isTotalPanenVisible,
                              isPendapatanVisible: _isPendapatanVisible,
                              onToggleTotalPanenVisibility: () {
                                setState(() {
                                  _isTotalPanenVisible =
                                      !_isTotalPanenVisible;
                                });
                              },
                              onTogglePendapatanVisibility: () {
                                setState(() {
                                  _isPendapatanVisible = !_isPendapatanVisible;
                                });
                              },
                            );
                          }
                        },
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 2,
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Lahan>>(
              future: _lahanFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  List<Lahan> lahanList = snapshot.data!;
                  List<Lahan> filteredLahanList = lahanList.where((lahan) {
                    return lahan.namaLahan
                        .toLowerCase()
                        .contains(searchQuery);
                  }).toList();

                  return Container(
                    height: 400,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: filteredLahanList.length,
                      itemBuilder: (context, index) {
                        var lahan = filteredLahanList[index];
                        return LahanListItem(
                          lahan: lahan,
                          onEdit: () async {
                            bool? updated = await showDialog(
                              context: context,
                              builder: (context) =>
                                  EditLahanDialog(lahan: lahan),
                            );
                            if (updated != null && updated) {
                              setState(() {
                                fetchData();
                              });
                            }
                          },
                          onDelete: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Delete Lahan'),
                                  content: Text(
                                      'Are you sure you want to delete ${lahan.namaLahan}?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Delete'),
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        await _deleteLahan(
                                            lahan.id); // Panggil fungsi delete
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
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
                      builder: (context) => HomeView(userId: widget.userId),
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
                icon: Icon(Icons.person),
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
        onPressed: () async {
          bool? added = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LahanScreen()),
          );
          if (added != null && added) {
            setState(() {
              fetchData();
            });
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }
}

// home.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ujidatapanen/screen/AddLahanScreen.dart';
import 'package:ujidatapanen/screen/login_screen.dart';
import 'package:ujidatapanen/service/ViewLahanService.dart';
import 'package:ujidatapanen/provider/AuthProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<dynamic>> _lahanFuture;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Fetch data di dalam initState
    fetchData();
  }

  void fetchData() {
    int userId = Provider.of<AuthProvider>(context, listen: false).userId ?? 0;
    _lahanFuture = ViewLahanService().fetchLahan(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tani Jaya'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'Profile':
                  // Navigasi ke halaman Profile saat menu dipilih
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                  break;
                case 'Logout':
                  // Navigasi ke halaman Login saat menu dipilih
                  Provider.of<AuthProvider>(context, listen: false).clearUser();
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
                  value: 'Profile',
                  child: Text('Profile'),
                ),
                PopupMenuItem(
                  value: 'Logout',
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _lahanFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    List<dynamic> lahanList = snapshot.data!;
                    List<dynamic> filteredLahanList = lahanList.where((lahan) {
                      return lahan['nama_lahan']
                          .toLowerCase()
                          .contains(searchQuery);
                    }).toList();

                    return ListView.builder(
                      itemCount: filteredLahanList.length,
                      itemBuilder: (context, index) {
                        var lahan = filteredLahanList[index];
                        return Card(
                          child: ListTile(
                            title: Text(lahan['nama_lahan']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Edit action
                                  },
                                  child: Text('Edit'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Delete action
                                  },
                                  child: Text('Del'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke layar LahanForm saat tombol ditekan
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LahanScreen()),
          );
        },
        child: Icon(Icons.add),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

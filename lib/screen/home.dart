// home.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ujidatapanen/screen/AddLahanScreen.dart';
import 'package:ujidatapanen/screen/login_screen.dart';
import 'package:ujidatapanen/service/ViewLahanService.dart';
import 'package:ujidatapanen/provider/AuthProvider.dart';


// home.dart
class HomeView extends StatefulWidget {
  final int userId;

  HomeView({required this.userId});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<dynamic>> _lahanFuture;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    _lahanFuture = ViewLahanService().fetchLahan(widget.userId);
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                  break;
                case 'Logout':
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


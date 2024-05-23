import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sosyal_surucu/profile_screen.dart';
import 'package:sosyal_surucu/news_screen.dart';
import 'package:sosyal_surucu/help_screen.dart';
import 'package:sosyal_surucu/groups_screen.dart';
import 'package:sosyal_surucu/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  final List<Map<String, dynamic>> _cards = [
    {
      'icon': Icons.article,
      'title': 'Son Haberler',
      'subtitle': 'En son haberler burada.',
      'screen': NewsScreen() // const kaldırıldı
    },
    {
      'icon': Icons.help,
      'title': 'Yardım Talepleri',
      'subtitle': 'Yardım taleplerini burada görebilirsiniz.',
      'screen': HelpScreen() // const kaldırıldı
    },
    {
      'icon': Icons.rule,
      'title': 'Trafik Kuralları',
      'subtitle': 'Trafik kuralları ve bilgiler.',
      'screen': null
    },
    {
      'icon': Icons.group,
      'title': 'Gruplar',
      'subtitle': 'Sosyal grupları burada görebilirsiniz.',
      'screen': GroupsScreen() // const kaldırıldı
    },
    {
      'icon': Icons.ad_units,
      'title': 'Sponsorlu İçerik',
      'subtitle': 'Reklamlar ve sponsorlu içerikler.',
      'screen': null
    },
  ];

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
    });
    Navigator.pop(context); // Drawer'ı kapat
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  Future<void> _refreshCards() async {
    setState(() {
      _cards.shuffle(); // Kartların yerini rastgele değiştir
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            setState(() {
            });
          },
          child: const Text('Sosyal Sürücü'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(user?.displayName ?? 'Kullanıcı Adı'),
              accountEmail: Text(user?.email ?? 'email@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(user?.photoURL ?? 'https://via.placeholder.com/150'),
              ),
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfileScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Profili Düzenle'),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.article),
              title: const Text('Haberler'),
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Yardım'),
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Gruplar'),
              onTap: () => _onItemTapped(2),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshCards,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Anasayfa',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                children: _cards.map((card) {
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: card['screen'] != null
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => card['screen']),
                              );
                            }
                          : null,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(card['icon'], size: 50),
                            const SizedBox(height: 10),
                            Text(card['title']),
                            Text(
                              card['subtitle'],
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

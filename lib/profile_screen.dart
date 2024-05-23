import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  Map<String, dynamic>? _userData;
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    _user = _auth.currentUser;
    if (_user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(_user!.uid).get();
      setState(() {
        _userData = userDoc.data() as Map<String, dynamic>?;
        if (_userData != null) {
          _cityController.text = _userData!['city'] ?? '';
          _districtController.text = _userData!['district'] ?? '';
        }
      });
    }
  }

  Future<void> _updateUserData() async {
    if (_user != null) {
      await _firestore.collection('users').doc(_user!.uid).update({
        'username': _userData!['username'],
        'name': _userData!['name'],
        'phone': _userData!['phone'],
        'email': _userData!['email'],
        'city': _cityController.text,
        'district': _districtController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profil güncellendi')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: _userData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.blueGrey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50.0,
                            backgroundImage: NetworkImage(_user?.photoURL ?? 'https://via.placeholder.com/150'),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            _userData!['username'] ?? 'Kullanıcı Adı',
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _userData!['email'] ?? 'email@example.com',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Profili Düzenle',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        ProfileSection(
                          title: 'Hesap Ayarları',
                          children: [
                            ListTile(
                              leading: const Icon(Icons.person),
                              title: const Text('Ad Soyad'),
                              subtitle: Text(_userData!['name'] ?? 'Ad Soyad'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.phone),
                              title: const Text('Telefon Numarası'),
                              subtitle: Text(_userData!['phone'] ?? 'Telefon Numarası'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.email),
                              title: const Text('E-posta Adresi'),
                              subtitle: Text(_userData!['email'] ?? 'email@example.com'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.location_city),
                              title: const Text('İl'),
                              subtitle: TextField(
                                controller: _cityController,
                                decoration: const InputDecoration(hintText: 'İl'),
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.location_on),
                              title: const Text('İlçe'),
                              subtitle: TextField(
                                controller: _districtController,
                                decoration: const InputDecoration(hintText: 'İlçe'),
                              ),
                            ),
                          ],
                        ),
                        ProfileSection(
                          title: 'Araç Bilgileri',
                          children: [
                            ListTile(
                              leading: const Icon(Icons.motorcycle),
                              title: const Text('Motosiklet'),
                              subtitle: Text(_userData!['motorcycle'] ?? 'Motosiklet Bilgisi'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.directions_car),
                              title: const Text('Otomobil'),
                              subtitle: Text(_userData!['automobile'] ?? 'Otomobil Bilgisi'),
                            ),
                          ],
                        ),
                        ProfileSection(
                          title: 'Başarımlar',
                          children: [
                            ListTile(
                              leading: const Icon(Icons.emoji_events),
                              title: const Text('Başarımlar'),
                              subtitle: const Text('Başarımlarınız burada listelenecek'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: _updateUserData,
                          child: const Text('Güncelle'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ProfileSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupAddRequestScreen extends StatefulWidget {
  const GroupAddRequestScreen({super.key});

  @override
  _GroupAddRequestScreenState createState() => _GroupAddRequestScreenState();
}

class _GroupAddRequestScreenState extends State<GroupAddRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;

  String? _groupType;
  String? _groupCategory;
  String? _platform;
  String? _city;
  String? _groupName;
  String? _groupLink;

  final List<String> _groupTypes = ['Sosyal', 'Teknik'];
  final List<String> _groupCategories = ['Araba', 'Motosiklet'];
  final List<String> _platforms = ['WhatsApp', 'Telegram', 'Discord'];
  final List<String> _cities = [
    'Adana', 'Adıyaman', 'Afyonkarahisar', 'Ağrı', 'Amasya', 'Ankara', 'Antalya', 'Artvin', 'Aydın', 'Balıkesir',
    'Bilecik', 'Bingöl', 'Bitlis', 'Bolu', 'Burdur', 'Bursa', 'Çanakkale', 'Çankırı', 'Çorum', 'Denizli', 'Diyarbakır',
    'Edirne', 'Elazığ', 'Erzincan', 'Erzurum', 'Eskişehir', 'Gaziantep', 'Giresun', 'Gümüşhane', 'Hakkari', 'Hatay',
    'Isparta', 'Mersin', 'İstanbul', 'İzmir', 'Kars', 'Kastamonu', 'Kayseri', 'Kırklareli', 'Kırşehir', 'Kocaeli',
    'Konya', 'Kütahya', 'Malatya', 'Manisa', 'Kahramanmaraş', 'Mardin', 'Muğla', 'Muş', 'Nevşehir', 'Niğde', 'Ordu',
    'Rize', 'Sakarya', 'Samsun', 'Siirt', 'Sinop', 'Sivas', 'Tekirdağ', 'Tokat', 'Trabzon', 'Tunceli', 'Şanlıurfa',
    'Uşak', 'Van', 'Yozgat', 'Zonguldak', 'Aksaray', 'Bayburt', 'Karaman', 'Kırıkkale', 'Batman', 'Şırnak', 'Bartın',
    'Ardahan', 'Iğdır', 'Yalova', 'Karabük', 'Kilis', 'Osmaniye', 'Düzce'
  ];

  Future<void> _submitRequest() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await _firestore.collection('group_add_requests').add({
        'groupType': _groupType,
        'groupCategory': _groupCategory,
        'platform': _platform,
        'city': _city,
        'groupName': _groupName,
        'groupLink': _groupLink,
        'status': 'pending',
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Grup ekleme başvurunuz gönderildi.')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grup Ekleme Başvuru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Grup Türü'),
                items: _groupTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _groupType = value;
                  });
                },
                validator: (value) => value == null ? 'Lütfen grup türünü seçin' : null,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Grup Kategorisi'),
                items: _groupCategories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _groupCategory = value;
                  });
                },
                validator: (value) => value == null ? 'Lütfen grup kategorisini seçin' : null,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Platform'),
                items: _platforms.map((platform) {
                  return DropdownMenuItem(
                    value: platform,
                    child: Text(platform),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _platform = value;
                  });
                },
                validator: (value) => value == null ? 'Lütfen platformu seçin' : null,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'İl'),
                items: _cities.map((city) {
                  return DropdownMenuItem(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _city = value;
                  });
                },
                validator: (value) => value == null ? 'Lütfen ili seçin' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Grup Adı'),
                validator: (value) => value!.isEmpty ? 'Lütfen grup adını girin' : null,
                onSaved: (value) {
                  _groupName = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Grup Davet Bağlantısı'),
                validator: (value) => value!.isEmpty ? 'Lütfen grup davet bağlantısını girin' : null,
                onSaved: (value) {
                  _groupLink = value;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitRequest,
                child: const Text('Başvuru Gönder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GroupListScreen extends StatefulWidget {
  final String category;
  final String platform;
  final String subcategory;

  const GroupListScreen({super.key, required this.category, required this.platform, required this.subcategory});

  @override
  _GroupListScreenState createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {
  String _selectedCity = 'Tüm İller';
  List<String> _filteredCities = [];
  final List<String> _cities = [
    'Tüm İller', 'Adana', 'Adıyaman', 'Afyonkarahisar', 'Ağrı', 'Amasya', 'Ankara', 'Antalya', 'Artvin',
    'Aydın', 'Balıkesir', 'Bilecik', 'Bingöl', 'Bitlis', 'Bolu', 'Burdur', 'Bursa', 'Çanakkale', 'Çankırı',
    'Çorum', 'Denizli', 'Diyarbakır', 'Edirne', 'Elazığ', 'Erzincan', 'Erzurum', 'Eskişehir', 'Gaziantep',
    'Giresun', 'Gümüşhane', 'Hakkari', 'Hatay', 'Isparta', 'Mersin', 'İstanbul', 'İzmir', 'Kars', 'Kastamonu',
    'Kayseri', 'Kırklareli', 'Kırşehir', 'Kocaeli', 'Konya', 'Kütahya', 'Malatya', 'Manisa', 'Kahramanmaraş',
    'Mardin', 'Muğla', 'Muş', 'Nevşehir', 'Niğde', 'Ordu', 'Rize', 'Sakarya', 'Samsun', 'Siirt', 'Sinop',
    'Sivas', 'Tekirdağ', 'Tokat', 'Trabzon', 'Tunceli', 'Şanlıurfa', 'Uşak', 'Van', 'Yozgat', 'Zonguldak',
    'Aksaray', 'Bayburt', 'Karaman', 'Kırıkkale', 'Batman', 'Şırnak', 'Bartın', 'Ardahan', 'Iğdır', 'Yalova',
    'Karabük', 'Kilis', 'Osmaniye', 'Düzce'
  ];

  final List<Map<String, dynamic>> socialGroups = const [
    {'name': 'Chopper Grupları', 'url': 'https://example.com/chopper', 'city': 'İstanbul'},
    {'name': 'Enduro Grupları', 'url': 'https://example.com/enduro', 'city': 'Ankara'},
  ];

  final List<Map<String, dynamic>> technicalGroups = const [
    {'name': 'Yamaha Teknik', 'url': 'https://example.com/yamaha', 'city': 'İzmir'},
    {'name': 'Honda Teknik', 'url': 'https://example.com/honda', 'city': 'Bursa'},
  ];

  List<Map<String, dynamic>> getGroupsByCategory(String category) {
    if (_selectedCity == 'Tüm İller') {
      return category == 'Sosyal' ? socialGroups : technicalGroups;
    } else {
      return category == 'Sosyal'
          ? socialGroups.where((group) => group['city'] == _selectedCity).toList()
          : technicalGroups.where((group) => group['city'] == _selectedCity).toList();
    }
  }

  @override
  void initState() {
    super.initState();
    _filteredCities = _cities;
  }

  void _filterCities(String query) {
    setState(() {
      _filteredCities = _cities.where((city) => city.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  void _selectCity(String city) {
    setState(() {
      _selectedCity = city;
    });
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final groups = getGroupsByCategory(widget.subcategory);
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} - ${widget.platform} - ${widget.subcategory}'),
        actions: [
          GestureDetector(
            onTap: () => _selectCity('Tüm İller'),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.white,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCity,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCity = newValue!;
                    });
                  },
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  dropdownColor: Colors.white,
                  items: _filteredCities.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: groups.map<Widget>((group) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(group['name']),
              subtitle: Text('İl: ${group['city']}'),
              trailing: ElevatedButton(
                onPressed: () {
                  _launchURL(group['url']);
                },
                child: const Text('Katıl'),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

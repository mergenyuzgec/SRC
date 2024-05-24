import 'package:flutter/material.dart';
import 'package:sosyal_surucu/screens/group_list_screen.dart'; // GroupListScreen dosyasını ekleyin

class SubcategoryScreen extends StatelessWidget {
  final String category;
  final String platform;

  const SubcategoryScreen({super.key, required this.category, required this.platform});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$platform Grupları'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(8.0),
        children: [
          _buildSubcategoryCard(context, 'Sosyal Gruplar', Icons.group),
          _buildSubcategoryCard(context, 'Teknik Gruplar', Icons.build),
        ],
      ),
    );
  }

  Widget _buildSubcategoryCard(BuildContext context, String subcategory, IconData icon) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GroupListScreen(category: category, platform: platform, subcategory: subcategory),
            ),
          );
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50),
              const SizedBox(height: 10),
              Text(subcategory, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sosyal_surucu/screens/subcategory_screen.dart'; // SubcategoryScreen dosyasını ekleyin
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // FontAwesome simgelerini ekleyin

class PlatformScreen extends StatelessWidget {
  final String category;

  const PlatformScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(8.0),
        children: [
          _buildPlatformCard(context, 'WhatsApp', FontAwesomeIcons.whatsapp),
          _buildPlatformCard(context, 'Telegram', FontAwesomeIcons.telegram),
          _buildPlatformCard(context, 'Discord', FontAwesomeIcons.discord),
        ],
      ),
    );
  }

  Widget _buildPlatformCard(BuildContext context, String platform, IconData icon) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubcategoryScreen(category: category, platform: platform),
            ),
          );
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50),
              const SizedBox(height: 10),
              Text(platform, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

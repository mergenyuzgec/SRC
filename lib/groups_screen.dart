import 'package:flutter/material.dart';
import 'package:sosyal_surucu/group_add_request_screen.dart';
import 'package:sosyal_surucu/platform_screen.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gruplar'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GroupAddRequestScreen()),
              );
            },
            child: Text(
              "Grup Ekle",
              style: TextStyle(
                color: Theme.of(context).appBarTheme.actionsIconTheme?.color ?? const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            _buildGroupCard(context, 'Araba Kullanıcıları', Icons.directions_car),
            _buildGroupCard(context, 'Motosiklet Kullanıcıları', Icons.motorcycle),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupCard(BuildContext context, String title, IconData icon) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlatformScreen(category: title),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            const SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

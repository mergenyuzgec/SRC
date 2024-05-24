import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sosyal_surucu/screens/group_add_request_screen.dart';
import 'package:url_launcher/url_launcher.dart';

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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('group_add_requests')
            .where('status', isEqualTo: 'approved')
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> approvedGroupsSnapshot) {
          if (approvedGroupsSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!approvedGroupsSnapshot.hasData || approvedGroupsSnapshot.data == null) {
            return const Center(child: Text('No data available'));
          }

          final approvedGroups = approvedGroupsSnapshot.data!.docs;

          if (approvedGroups.isEmpty) {
            return const Center(child: Text('No approved groups found.'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: approvedGroups.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (ctx, index) {
              final group = approvedGroups[index];
              return _buildGroupCard(
                context,
                group['groupName'],
                _getIconForGroupType(group['groupType']),
                group['groupLink'],
              );
            },
          );
        },
      ),
    );
  }

  IconData _getIconForGroupType(String groupType) {
    switch (groupType) {
      case 'Araba':
        return Icons.directions_car;
      case 'Motosiklet':
        return Icons.motorcycle;
      default:
        return Icons.group;
    }
  }

  Widget _buildGroupCard(BuildContext context, String title, IconData icon, String url) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
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

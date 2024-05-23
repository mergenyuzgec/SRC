import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminGroupRequestsScreen extends StatefulWidget {
  @override
  _AdminGroupRequestsScreenState createState() => _AdminGroupRequestsScreenState();
}

class _AdminGroupRequestsScreenState extends State<AdminGroupRequestsScreen> {
  final _firestore = FirebaseFirestore.instance;

  Future<void> _approveRequest(DocumentSnapshot request) async {
    await _firestore.collection('groups').add({
      'groupType': request['groupType'],
      'groupCategory': request['groupCategory'],
      'platform': request['platform'],
      'city': request['city'],
      'groupName': request['groupName'],
      'groupLink': request['groupLink'],
    });
    await _firestore.collection('group_add_requests').doc(request.id).update({'status': 'approved'});
  }

  Future<void> _rejectRequest(DocumentSnapshot request) async {
    await _firestore.collection('group_add_requests').doc(request.id).update({'status': 'rejected'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grup Ekleme Başvuruları'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('group_add_requests').where('status', isEqualTo: 'pending').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final requests = snapshot.data!.docs;

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(request['groupName']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tür: ${request['groupType']}'),
                      Text('Kategori: ${request['groupCategory']}'),
                      Text('Platform: ${request['platform']}'),
                      Text('İl: ${request['city']}'),
                      Text('Bağlantı: ${request['groupLink']}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check, color: Colors.green),
                        onPressed: () => _approveRequest(request),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.red),
                        onPressed: () => _rejectRequest(request),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

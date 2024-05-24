import 'package:flutter/material.dart';

class ShareGroupLinkScreen extends StatelessWidget {
  final TextEditingController _platformController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  ShareGroupLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grup Linki Paylaş'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _platformController,
              decoration: const InputDecoration(labelText: 'Platform'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Açıklama'),
            ),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(labelText: 'URL'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Başvuru işlemleri burada gerçekleştirilecek
                // Örneğin, Firestore'a başvuruyu kaydedebilirsiniz
              },
              child: const Text('Paylaşım Başvurusunda Bulun'),
            ),
          ],
        ),
      ),
    );
  }
}

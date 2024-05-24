import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key}); // const anahtar kelimesini ekleyin

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Haberler'), // const anahtar kelimesini ekleyin
      ),
      body: const Center(
        child: Text('Haberler içeriği'), // const anahtar kelimesini ekleyin
      ),
    );
  }
}

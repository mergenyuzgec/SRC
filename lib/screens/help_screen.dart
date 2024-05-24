import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key}); // const anahtar kelimesini ekleyin

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yardım'), // const anahtar kelimesini ekleyin
      ),
      body: const Center(
        child: Text('Yardım içeriği'), // const anahtar kelimesini ekleyin
      ),
    );
  }
}

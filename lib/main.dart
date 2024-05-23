import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sosyal_surucu/routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sosyal Sürücü',
      initialRoute: '/',
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false, // Debug etiketini kaldırır
    );
  }
}

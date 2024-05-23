import 'package:flutter/material.dart';
import 'package:sosyal_surucu/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print('Giriş başarısız: $e');
      _showSnackbar('Giriş başarısız! Lütfen tekrar deneyin.');
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _resetPassword() async {
    if (_emailController.text.isEmpty) {
      _showSnackbar('Lütfen e-posta adresinizi girin');
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
      _showSnackbar('Şifre sıfırlama e-postası gönderildi');
    } catch (e) {
      print('Şifre sıfırlama hatası: $e');
      _showSnackbar('Şifre sıfırlama hatası! Lütfen tekrar deneyin.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sosyal Sürücü'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Giriş Yap veya Kayıt Ol',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'E-posta',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Şifre',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _login,
                    child: const Text('Giriş Yap'),
                  ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });

                try {
                  User? user = await _authService.signInWithGoogle();
                  if (user != null) {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                } catch (e) {
                  print('Google ile giriş başarısız: $e');
                  _showSnackbar('Google ile giriş başarısız! Lütfen tekrar deneyin.');
                }

                setState(() {
                  _isLoading = false;
                });
              },
              child: const Text('Google ile Bağlan'),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text('Yeni hesap oluştur'),
            ),
            TextButton(
              onPressed: _resetPassword,
              child: const Text('Şifremi Unuttum'),
            ),
          ],
        ),
      ),
    );
  }
}

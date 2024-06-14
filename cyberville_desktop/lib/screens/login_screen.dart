import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'register_screen.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Simples verificação do login
    if (_usernameController.text == 'user' && _passwordController.text == 'password') {
      prefs.setBool('isLoggedIn', true);
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // Mostre uma mensagem de erro
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário ou senha incorretos')),
      );
    }
  }

  void _accessWithoutLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background, // Muda a cor de fundo aqui
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png', // Caminho da imagem do logotipo
              height: 100, // Ajuste o tamanho conforme necessário
            ),
            const SizedBox(height: 20), // Espaço entre a imagem e o formulário
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Usuário'),
              style: const TextStyle(
                fontFamily: 'upheavtt', // Define a fonte do texto
                fontSize: 16, // Tamanho da fonte
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
              style: const TextStyle(
                fontFamily: 'upheavtt', // Define a fonte do texto
                fontSize: 16, // Tamanho da fonte
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: neutral, // Muda a cor do botão aqui
                textStyle: const TextStyle(
                  fontFamily: 'upheavtt', // Define a fonte do texto no botão
                  fontSize: 18, // Tamanho da fonte
                ),
              ),
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
              child: const Text(
                'Cadastrar',
                style: TextStyle(
                  fontFamily: 'upheavtt', // Define a fonte do texto
                  fontSize: 16, // Tamanho da fonte
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _accessWithoutLogin,
              child: const Text(
                'Acessar sem login',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontFamily: 'upheavtt', // Define a fonte do texto
                  fontSize: 20, // Tamanho da fonte
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'login_screen.dart';
import '../constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<Database> _openDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'users.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT, password TEXT, email TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> _register() async {
    if (_usernameController.text.isEmpty || 
        _passwordController.text.isEmpty || 
        _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos')),
      );
      return;
    }

    try {
      final db = await _openDatabase();

      // Verificar se o usuário já existe
      List<Map<String, dynamic>> existingUsers = await db.query(
        'users',
        where: 'username = ?',
        whereArgs: [_usernameController.text],
      );

      if (existingUsers.isNotEmpty) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          const SnackBar(content: Text('Usuário já existe')),
        );
        return;
      }

      await db.insert(
        'users',
        {
          'username': _usernameController.text,
          'password': _passwordController.text,
          'email': _emailController.text,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(content: Text('Usuário cadastrado com sucesso!')),
      );

      Navigator.pushReplacement(
        context as BuildContext,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(content: Text('Erro ao cadastrar usuário')),
      );
    }
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
              'assets/cadastrar.png', // Caminho da imagem do logotipo
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
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              style: const TextStyle(
                fontFamily: 'upheavtt', // Define a fonte do texto
                fontSize: 16, // Tamanho da fonte
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: neutral, // Muda a cor do botão aqui
                textStyle: const TextStyle(
                  fontFamily: 'upheavtt', // Define a fonte do texto no botão
                  fontSize: 18, // Tamanho da fonte
                ),
              ),
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}

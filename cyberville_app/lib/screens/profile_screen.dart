import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente
            crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
            children: <Widget>[
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://www.example.com/avatar.jpg'), // URL da imagem do perfil
              ),
              const SizedBox(height: 20),
              const Text(
                'Nome do Usuário',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'E-mail: usuario@example.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Ação para editar perfil
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                child: const Text('Editar Perfil'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

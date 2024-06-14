import 'package:cyberville_app/constants.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário', style: TextStyle(
          color: neutral,
          fontFamily: 'upheavtt',
        ),),
      backgroundColor: background,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/perfil.png'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Johnny',
                style: TextStyle(
                  fontSize: 24,
                  color: fontcolor,
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
                  foregroundColor: neutral,
                  backgroundColor: background,
                ),
                child: const Text('Editar Perfil',
                 style: TextStyle(fontFamily: 'upheavtt', fontSize: 20.0),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

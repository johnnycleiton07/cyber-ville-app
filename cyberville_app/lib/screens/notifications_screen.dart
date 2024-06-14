import 'package:flutter/material.dart';
import '/constants.dart'; // Importe seus constantes personalizadas aqui, se necessário.

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notificações',
          style: TextStyle(
            fontFamily: 'upheavtt',
            fontSize: 20.0,
            height: 0,
            color: neutral,
          ),
        ),
        backgroundColor: background, // Cor de fundo da app bar
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding para o conteúdo central
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente
            crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
            children: <Widget>[
              const Icon(
                Icons.notifications,
                size: 80,
                color: fontcolor, // Cor do ícone
              ),
              const SizedBox(height: 20),
              const Text(
                'Você não tem novas notificações',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Arial',
                  color: fontcolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Ação para mostrar notificações ou qualquer outra ação desejada
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: neutral,
                  backgroundColor: background, // Cor do botão
                ),
                child: const Text('Atualizar', 
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'upheavtt',
                  color: neutral,),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

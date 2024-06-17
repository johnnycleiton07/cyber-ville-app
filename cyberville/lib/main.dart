import 'package:cyberville_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // remove o debug banner
      debugShowCheckedModeBanner: false,
      // obtendo a homepage
      home: FutureBuilder<bool>(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: background,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ); // Mostra um indicador de progresso enquanto verifica o status de login
          } else if (snapshot.data == true) {
            return const HomeScreen(); // Vai para a HomeScreen se estiver logado
          } else {
            return const LoginScreen(); // Vai para a LoginScreen se não estiver logado
          }
        },
      ),
    );
  }

  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}

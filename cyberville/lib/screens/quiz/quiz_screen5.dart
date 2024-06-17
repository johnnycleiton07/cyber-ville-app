import 'package:flutter/material.dart';
import '/constants.dart';
import '../next/next_screen5.dart';

class QuizScreen5 extends StatelessWidget {
  const QuizScreen5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Missão V - fake news',
          style: TextStyle(
            fontFamily: 'upheavtt',
            fontSize: 20.0,
            height: 0,
            color: neutral,
          ),
        ),
        backgroundColor: background,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Em cyberville é comum existir\n dispositivos inteligentes e bem informados. Alexa é um exemplo!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'upheavtt',
                color: fontcolor,
              ),
            ),
            const SizedBox(height: 20.0),
            Image.asset('assets/alexa_aplanta.png', height: 200),
            const SizedBox(height: 20.0),
            const Text(
              'Ajude a planta a espalhar\n boas práticas de obtenção\n de informação online',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'upheavtt',
                color: fontcolor,
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: highlight.withOpacity(0.5),
                    blurRadius: 8.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NextScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: highlight,
                  backgroundColor: fontcolor,
                  textStyle: const TextStyle(
                    fontFamily: 'upheavtt',
                    fontSize: 20.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                ),
                child: const Text('Começar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

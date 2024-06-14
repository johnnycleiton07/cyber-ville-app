import 'package:flutter/material.dart';
import '/constants.dart';
import '../next/next_screen4.dart';

class QuizScreen4 extends StatelessWidget {
  const QuizScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Missão IV - Segurança',
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
              'Ele é um verdadeiro aliado\n ao controle parental\n no mundo digital',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'upheavtt',
                color: fontcolor,
              ),
            ),
            const SizedBox(height: 20.0),
            Image.asset('assets/policial_vector.png', height: 200),
            const SizedBox(height: 20.0),
            const Text(
              'Ajude Vector a proteger\n outras crianças dos perigos online em CyberVille',
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

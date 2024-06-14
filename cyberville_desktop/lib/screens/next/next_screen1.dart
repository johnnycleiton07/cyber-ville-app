import 'package:flutter/material.dart';
import '../../constants.dart';
import '/models/question_model.dart';
import '../../widgets/question_widget.dart';

class NextScreen extends StatefulWidget {
  const NextScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  int _currentIndex = 0;
  int _score = 0;
  String _selectedOption = '';
  bool _isOptionSelected = false;
  bool _showCorrect = false;

  final List<Question> _questions = [
  Question(
    id: '10',
    title: 'Qual das senhas de 8 dígitos abaixo é a mais segura?',
    options: {
      '12345678': false,
      'abcdefgh': false,
      'abcd1234': false,
      'AhPwo#29': true,
      '1234abcd': false,
    },
  ),
  Question(
    id: '11',
    title: 'Por que é importante mudar suas senhas regularmente?',
    options: {
      'Porque é divertido': false,
      'Para evitar que outras pessoas adivinhem': true,
      'Porque a senha expira': false,
      'Para que você possa lembrar mais facilmente': false,
      'Porque os sites pedem': false,
    },
  ),
  Question(
    id: '12',
    title: 'O que você NÃO deve fazer com sua senha?',
    options: {
      'Compartilhar com amigos': true,
      'Guardar em um lugar seguro': false,
      'Usar letras maiúsculas e minúsculas': false,
      'Incluir números e símbolos': false,
      'Criar uma senha longa': false,
    },
  ),
  Question(
    id: '13',
    title: 'O que fazer se você esquecer sua senha?',
    options: {
      'Parar de usar o site': false,
      'Tentar adivinhar várias vezes': false,
      'Pedir ajuda ao site para redefinir': true,
      'Usar a senha de um amigo': false,
      'Criar uma nova conta': false,
    },
  ),
  Question(
    id: '14',
    title: 'Qual é a melhor prática ao criar uma senha segura?',
    options: {
      'Usar seu nome': false,
      'Usar "123456"': false,
      'Usar uma combinação de letras, números e símbolos': true,
      'Usar "senha"': false,
      'Usar a mesma senha para todos os sites': false,
    },
  ),
];


  void _nextQuestion() {
    setState(() {
      _currentIndex++;
      _isOptionSelected = false;
      _selectedOption = '';
      _showCorrect = false;
    });
  }

  void _onOptionSelected(String option) {
    if (!_isOptionSelected) {
      setState(() {
        _isOptionSelected = true;
        _selectedOption = option;
        _showCorrect = _questions[_currentIndex].options[option] == true;
        if (_showCorrect) {
          _score++;
        }
      });
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (_currentIndex < _questions.length - 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransitionScreen(
                nextQuestionCallback: _nextQuestion,
              ),
            ),
          );
        } else {
          _showCompletionDialog();
        }
      });
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Quiz Finalizado!',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'upheavtt',
            color: fontcolor,
          ),
        ),
        content: Text(
          'Você teve $_score acertos de ${_questions.length}.',
          style: const TextStyle(
            fontSize: 18,
            color: fontcolor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Return to the previous screen
            },
            child: const Text(
              'OK',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: fontcolor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        backgroundColor: background,
        shadowColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuestionWidget(
              indexAction: _currentIndex,
              question: question.title,
              totalQuestions: _questions.length,
            ),
            const Divider(color: background),
            const SizedBox(height: 20.0),
            for (var option in question.options.keys)
              InkWell(
                onTap: () => _onOptionSelected(option),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0), // Ajuste o espaçamento vertical aqui
                  padding: const EdgeInsets.all(20.0), // Ajuste o tamanho do quadrado aqui
                  decoration: BoxDecoration(
                    color: _isOptionSelected
                        ? (question.options[option] == true ? Colors.green[100] : (_selectedOption == option ? Colors.red[100] : Colors.white))
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 8.0),
                      Expanded(child: Text(option)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TransitionScreen extends StatelessWidget {
  final VoidCallback nextQuestionCallback;

  const TransitionScreen({super.key, required this.nextQuestionCallback});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      nextQuestionCallback();
      Navigator.pop(context);
    });

    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          ' ',
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}

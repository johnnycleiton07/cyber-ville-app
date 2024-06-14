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
      title: 'O que são fake news?',
      options: {'Notícias engraçadas': false, 
                'Notícias falsas': true, 
                'Notícias sobre celebridades': false, 
                'Notícias do futuro': false, 
                'Notícias em quadrinhos': false},
    ),
    Question(
      id: '11',
      title: 'Quem cria as fake news?',
      options: {'Cientistas': false, 
                'Pessoas que querem confundir os outros': true, 
                'Seus amigos': false, 
                'Animais de estimação': false, 
                'Professores': false},
    ),
    Question(
      id: '12',
      title: 'Como você pode verificar se uma notícia é verdadeira?',
      options: {'Perguntar para qualquer pessoa': false, 
                'Acreditar na primeira coisa que ler': false, 
                'Ignorar completamente a notícia': false, 
                'Pedir para seus amigos confirmarem': false, 
                'Verificar em diferentes fontes confiáveis': true},
    ),
    Question(
      id: '13',
      title: 'O que você deve fazer se receber uma notícia que parece estranha?',
      options: {'Compartilhar imediatamente nas redes sociais': false, 
                'Não fazer nada e esquecer': false, 
                'Perguntar aos pais ou professores': true, 
                'Criar uma história ainda mais engraçada': false, 
                'Guardar a notícia só para você': false},
    ),
    Question(
      id: '14',
      title: 'Por que é importante não compartilhar fake news?',
      options: {'Porque todos fazem isso': false, 
                'Porque pode confundir as pessoas': true, 
                'Porque é engraçado': false, 
                'Porque não importa': false, 
                'Porque vai tornar você popular': false},
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

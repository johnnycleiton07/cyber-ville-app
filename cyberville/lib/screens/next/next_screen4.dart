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
      title: 'Por que é importante o controle parental nos dispositivos que você usa?',
      options: {'Para garantir que você tenha acesso a todos os sites': false, 
                'Para limitar o tempo de uso e bloquear conteúdo inadequado': true, 
                'Para impedir que você jogue online': false, 
                'Para permitir downloads ilimitados': false, 
                'Para controlar o volume do dispositivo': false},
    ),
    Question(
      id: '11',
      title: 'O que fazer se encontrar algo na internet que te deixe desconfortável ou com medo?',
      options: {'Ignorar e continuar navegando': false, 
                'Contar imediatamente a um adulto de confiança': true, 
                'Compartilhar com seus amigos para ver o que eles acham': false, 
                'Tentar resolver o problema sozinho': false, 
                'Desligar o dispositivo e esquecer o que viu': false},
    ),
    Question(
      id: '12',
      title: 'Por que é importante que seus pais saibam com quem você está se comunicando online?',
      options: {'Para garantir que você esteja seguro': true, 
                'Para que eles possam monitorar suas conversas': false, 
                'Para adicionar mais amigos à sua lista de contatos': false, 
                'Para ter certeza de que você está se divertindo': false, 
                'Para ajudar você a responder mais rápido': false},
    ),
    Question(
      id: '13',
      title: 'Por que é importante conversar com seus pais antes de baixar novos aplicativos ou jogos?',
      options: {'Para saber se o aplicativo ou jogo é seguro e apropriado para sua idade': true, 
                'Para garantir que você tenha espaço suficiente no dispositivo': false, 
                'Para ver se eles já jogaram o jogo': false, 
                'Para saber se o aplicativo ou jogo é popular': false, 
                'Para verificar se o app ou jogo é gratuito': false},
    ),
    Question(
      id: '14',
      title: 'Por que é importante não encontrar pessoalmente alguém que conheceu online?',
      options: {'Porque pode ser perigoso encontrar quem você não conhece pessoalmente': true, 
                'Porque eles podem querer te dar presentes': false, 
                'Porque pode ser uma oportunidade para fazer novos amigos': false, 
                'Porque pode ser divertido': false, 
                'Porque você pode gostar de conhecer': false},
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

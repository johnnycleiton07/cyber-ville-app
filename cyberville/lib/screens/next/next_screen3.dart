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
    title: 'Por que é importante não compartilhar informações pessoais em chats de jogos online?',
    options: {
      'Porque pode ocupar muito espaço no chat': false,
      'Porque desconhecidos podem usar essas informações de maneira inadequada': true,
      'Porque os outros jogadores podem ficar com ciúmes': false,
      'Porque pode fazer o jogo ficar mais lento': false,
      'Porque pode atrapalhar a jogabilidade': false,
    },
  ),
  Question(
    id: '11',
    title: 'O que você deve fazer se um jogador desconhecido pedir para você adicionar ele como amigo fora do jogo?',
    options: {
      'Adicionar para ter mais amigos': false,
      'Pedir para outros jogadores adicionarem primeiro': false,
      'Adicionar e compartilhar informações pessoais': false,
      'Não adicionar e informar um adulto': true,
      'Aceitar o pedido e continuar jogando': false,
    },
  ),
  Question(
    id: '12',
    title: 'Por que é importante escolher um nome de usuário seguro e apropriado para jogos online?',
    options: {
      'Para que os amigos possam encontrar você facilmente': false,
      'Para impressionar outros jogadores': false,
      'Para ganhar mais pontos no jogo': false,
      'Para evitar compartilhar informações pessoais ou atrair comportamentos inadequados': true,
      'Para seguir as regras do jogo': false,
    },
  ),
  Question(
    id: '13',
    title: 'Por que é importante ser respeitoso e educado com outros jogadores online?',
    options: {
      'Para ganhar mais pontos no jogo': false,
      'Para criar um ambiente de jogo agradável e seguro para todos': true,
      'Para ser convidado para mais partidas': false,
      'Para evitar ser banido do jogo': false,
      'Para receber mais presentes e bônus no jogo': false,
    },
  ),
  Question(
    id: '14',
    title: 'Por que é importante evitar clicar em links suspeitos enviados por outros jogadores no chat do jogo?',
    options: {
      'Porque podem levar a sites inseguros que roubam suas informações': true,
      'Porque podem demorar para carregar': false,
      'Porque ocupam muito espaço no chat': false,
      'Porque podem ser sobre jogos que você não conhece': false,
      'Porque podem fazer você perder o foco': false,
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

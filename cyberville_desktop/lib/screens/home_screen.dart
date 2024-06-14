import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'notifications_screen.dart';
import 'quiz/quiz_screen1.dart';
import 'quiz/quiz_screen2.dart';
import 'quiz/quiz_screen3.dart';
import 'quiz/quiz_screen4.dart';
import 'quiz/quiz_screen5.dart';
import '../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;

  static const List<Widget> _widgetOptions = <Widget>[
    NotificationsScreen(),
    HomeContent(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Missões em',
              style: TextStyle(
                fontFamily: 'upheavtt',
                fontSize: 30.0,
                height: 0,
                color: neutral,
              ),
            ),
            Text(
              'CyberVille',
              style: TextStyle(
                fontFamily: 'upheavtt',
                fontSize: 40.0,
                height: 0.30,
                color: neutral,
              ),
            ),
          ],
        ),
        backgroundColor: background,
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: unselected,
        unselectedItemColor: selected,
        backgroundColor: background,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 120.0),
              buildMissionButton(context, 'assets/missao1.png', const QuizScreen1()),
              const SizedBox(height: 0.0),
              buildMissionButton(context, 'assets/missao2.png', const QuizScreen2()),
              const SizedBox(height: 0.0),
              buildMissionButton(context, 'assets/missao3.png', const QuizScreen3()),
              const SizedBox(height: 0.0),
              buildMissionButton(context, 'assets/missao4.png', const QuizScreen4()),
              const SizedBox(height: 0.0),
              buildMissionButton(context, 'assets/missao5.png', const QuizScreen5()),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            color: background,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
            child: const Text(
              'Obtenha conhecimento em segurança online completando as missões',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'upheavtt',
                fontSize: 20.0,
                height: 1.0,
                color: fontcolor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMissionButton(BuildContext context, String imagePath, Widget screen) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40.0),
      color: neutral,
      child: MissionButton(imagePath: imagePath, screen: screen),
    );
  }
}

class MissionButton extends StatefulWidget {
  final String imagePath;
  final Widget screen;

  const MissionButton({super.key, required this.imagePath, required this.screen});

  @override
  // ignore: library_private_types_in_public_api
  _MissionButtonState createState() => _MissionButtonState();
}

class _MissionButtonState extends State<MissionButton> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget.screen),
        );
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Image.asset(
          widget.imagePath,
          height: 200,
        ),
      ),
    );
  }
}

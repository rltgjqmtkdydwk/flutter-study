import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

// Stateful위젯의 STATE : 상태에 따라 변하는 데이터를 넣을 수 있다
class _AppState extends State<App> {
  int counter = 0; // final이 아님(변하는 값)

  void onClicked() {
    counter += 1;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFF4EDDB),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Click Count',
                style: TextStyle(fontSize: 30),
              ),
              Text(
                '$counter', //눌러도 버튼이 작동하지 않는다?
                style: const TextStyle(fontSize: 30),
              ),
              IconButton(
                iconSize: 40,
                onPressed: onClicked,
                icon: const Icon(Icons.add_box_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

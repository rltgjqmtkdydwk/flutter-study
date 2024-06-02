import 'package:flutter/material.dart';
import 'package:webtoon_app/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key}); // 모든 widget은 key를 갖고 있다(=flutter가 위젯을 식별하는 ID)

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

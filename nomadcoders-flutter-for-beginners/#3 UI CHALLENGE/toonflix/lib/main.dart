import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // MyApp() == root widget : App의 시작점
}


class MyApp extends StatelessWidget { 
  // MyApp을 widget으로 바꿔주기 위해 상속. StatelessWidget은 build 메소드를 필요로 함

  @override // 부모클래스의 build 메소드 구현
  Widget build(BuildContext context) {
    // 어떤 위젯 return 해줄까? 루트 위젯(여기서는 MyApp)은 디자인 시스템을 return해야함.
    // 디자인 시스템 : material(구글style) 또는 cupertino(IOSstyle)
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Hello Flutter'),
        ),
        body: Center(
          child: Text('hello world'),
          ),
        ),
      );
  }

}
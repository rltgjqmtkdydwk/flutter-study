import 'package:flutter/material.dart';
import 'package:webtoon_app/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //동작을 감지하는 위젯
      //stateless 위젯을 스크린인 것처럼 보이게
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              thumb: thumb,
              id: id,
            ),
            fullscreenDialog: true, //화면이 아래서부터 나타남
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 250,
            clipBehavior:
                Clip.hardEdge, //clipBehavior: 자식이 부모영역에 침범하는 것을 제어하는 방법
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  offset: const Offset(10, 10),
                  color:
                      Colors.black.withOpacity(0.5), //color를 가장 나중에 설정하면 보기 편함
                ),
              ],
            ),
            child: Image.network(thumb), //Image 위젯
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

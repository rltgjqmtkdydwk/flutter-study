import 'package:flutter/material.dart';
import 'package:webtoon_app/model/webtoon_model.dart';
import 'package:webtoon_app/services/api_service.dart';
import 'package:webtoon_app/widget/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(fontSize: 24),
        ),
      ),
      // 똑똑한 data fetching : FutureBuilder() 쓰기
      body: FutureBuilder(
        future: webtoons, //자동으로 await
        builder: (context, snapshot) {
          //snapshot: future의 상태
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot)) //makeList 메소드로 묶어주기
                //ERROR: makeList는 높이를 알수 없기 때문에 -> Expanded() 사용
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(
          vertical: 10, horizontal: 20), // 이미지 상단 그림자 표시하기 위한 padding
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}

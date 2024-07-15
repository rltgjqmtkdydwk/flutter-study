import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; //shared_preferences로 핸드폰 저장소에 데이터 저장하기
import 'package:webtoon_app/model/webtoon_datail_model.dart';
import 'package:webtoon_app/model/webtoon_episode_model.dart';
import 'package:webtoon_app/services/api_service.dart';
import 'package:webtoon_app/widget/episode_widget.dart'; //widget으로 분리

class DetailScreen extends StatefulWidget {
  // stateless -> stateful 변환한 이유: initState() 쓰려고
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  //초기화하고 싶은 변수가 있지만 constructor에서 불가능한 경우, late
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late SharedPreferences prefs;
  bool isLiked = false;

  //가장 먼저, 핸드폰 저장소와 연결할 connection 만들어주기(=초기화)
  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons'); //'likedToons' key 확인
    if (likedToons != null) {
      if (likedToons.contains(widget.id) == true) {
        //!!! initState를 했더라도 좋아요 상태를 유지하려면 setState를 해야함(ui 새로고침)
        setState(() {
          isLiked = true; //좋아요를 누른 웹툰
        });
      }
    } else {
      prefs.setStringList('likedToons', []);
    }
  }

  //late Future변수인 webtoon, episodes 안전하게 초기화
  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
    //별개의 class(=state<DetailScreen>)에 data(=id)가 들어가기 때문에, 해당 widget class(stateful widget)를 통해 data를 전달해야 한다.
    initPrefs();
  }

  onHeartTab() async {
    final likedToons = prefs.getStringList('likedToons'); //리스트 가져오기
    if (likedToons != null) {
      if (isLiked) {
        //좋아요 한 웹툰
        likedToons.remove(widget.id);
      } else {
        //좋아요하지 않은 웹툰
        likedToons.add(widget.id);
      }
      //핸드폰 저장소 업데이트
      await prefs.setStringList('likedToons', likedToons);
      setState(() {
        isLiked != isLiked; //좋아요 상태 바꾸기
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          widget.title, //웹툰이름으로 표시
          style: const TextStyle(fontSize: 24),
        ),
        actions: [
          //좋아요 누른 리스트 반영하는 action
          IconButton(
            onPressed: onHeartTab,
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_outline,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //같은 tag를 공유할 때 애니메이션
                  Hero(
                    tag: widget.id,
                    child: Container(
                      width: 250,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            offset: const Offset(10, 10),
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                      child: Image.network(widget.thumb),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${snapshot.data!.age} / ${snapshot.data!.genre}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    );
                  }
                  return const Text("...");
                },
              ), //builder : widget을 return하는 함수
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // episodes를 어떻게 화면에 그릴 것인가? ListView vs Column
                    // list가 많으면 ListView, 적으면 최적화를 위해 Column
                    return Column(
                      children: [
                        for (var episode in snapshot.data!)
                          Episode(
                            episode: episode,
                            webtoonId: widget.id,
                          )
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

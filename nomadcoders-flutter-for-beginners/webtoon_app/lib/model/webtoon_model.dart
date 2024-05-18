class WebtoonModel {
  final String title, thumb, id;

  //this. 대신 named constructor 사용
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}

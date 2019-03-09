import 'package:flutter/foundation.dart';

class Event {
  final String title;
  final String details;
  final String imageURL;
  bool isExpanded = false;

  Event({
    @required this.title,
    @required this.details,
    @required this.imageURL,
  })  : assert(title != null),
        assert(details != null),
        assert(imageURL != null);
}

List<Event> exampleEvents = <Event>[
  Event(
      title: "팜스 발리",
      details:
          "밀가루로 된 얇고 납작한 반죽(도우)에 토마토 소스와 치즈 등(토핑)을 얹어서 구워내는 이탈리아 요리다. 이탈리아를 대표하는 요리 중 하나로 한국인들이 많이 즐기는 서양 음식 중 하나이기도 하다.",
      imageURL:
          "https://previews.123rf.com/images/imagestore/imagestore1411/imagestore141100095/33748877-%ED%9D%B0%EC%83%89-%EB%B0%B0%EA%B2%BD%EC%97%90-%EC%9C%84%EC%AA%BD%EC%97%90%EC%84%9C-%ED%98%BC%ED%95%A9-%ED%94%BC%EC%9E%90.jpg"),
  Event(
      title: "한동대학교",
      details: "경상북도 포항시 북구 흥해읍 한동로 558(舊 남송리 3)에 있는 개신교 계열 종합대학이다. 초대 총장인 김영길 박사가 (1995.01.21~ 2014.01.31)의 기간동안 총장직에 재직하고 퇴임하였다. 현재는 장순흥 제5대 총장이(2014.02.04~ ) 공식 취임하여 2018.1.31까지 4년 임기의 총장직을 맡게 되었다.",
      imageURL: "https://upload.wikimedia.org/wikipedia/commons/6/62/%ED%95%99%EA%B5%90.jpg")
];

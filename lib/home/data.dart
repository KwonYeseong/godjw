class IntroItem {
  IntroItem({
    this.title,
    this.category,
    this.imageUrl,
  });

  final String title;
  final String category;
  final String imageUrl;
}

final sampleItems = <IntroItem>[
  new IntroItem(
    title: 'Writing things together is what we do best!',
    category: 'COLLABORATION',
    imageUrl:
        'https://image.ohou.se/image/resize/bucketplace-v2-development/uploads-cards-snapshots-1551925754_jAXMLOKq.jpeg/1536/none',
  ),
  new IntroItem(
    title: 'Occasionally wearing pants is a good idea.',
    category: 'CULTURE',
    imageUrl:
        'https://image.ohou.se/image/resize/bucketplace-v2-development/uploads-cards-snapshots-1546573394_oLzoi.jpeg/1536/none',
  ),
  new IntroItem(
    title: 'We might have the best team spirit ever.',
    category: 'SPIRIT',
    imageUrl:
        'https://image.ohou.se/image/resize/bucketplace-v2-development/uploads-cards-snapshots-1546917667_ZfMTt.jpeg/1536/none',
  ),
];

class UsedItem {
  UsedItem({
    this.name,
    this.price,
    this.imageUrl,
  });

  final String name;
  final String price;
  final String imageUrl;
}

final sampleUsedItem = <UsedItem>[
  new UsedItem(
      name: "Home!!",
      price: "30,000",
      imageUrl:
          'https://image.ohou.se/image/resize/bucketplace-v2-development/uploads-cards-snapshots-1551925754_jAXMLOKq.jpeg/1536/none'),
  new UsedItem(
      name: "Sweet!!",
      price: "50,000",
      imageUrl:
          'https://image.ohou.se/image/resize/bucketplace-v2-development/uploads-cards-snapshots-1546573394_oLzoi.jpeg/1536/none'),
  new UsedItem(
      name: "Home!!",
      price: "70,000",
      imageUrl:
          'https://image.ohou.se/image/resize/bucketplace-v2-development/uploads-cards-snapshots-1546917667_ZfMTt.jpeg/1536/none'),
];

class Tip {
  Tip({this.title, this.content});
  final String title;
  final String content;
}

final Tips = <Tip>[
  new Tip(title: "천마지 가는 꿀팁", content: "파워 플랜드 뒤쪽으로 가서 산길을 따라 들어간다"),
  new Tip(title: "전전 인싸가 되는 법", content: "갓지우님과 친해지면 됩니다"),
];

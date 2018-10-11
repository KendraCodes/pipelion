import 'model.dart';

AssetData loadAsset(String assetID) {
  return null;//new AssetData();
}

PostData loadPost(String postID) {
  return null; //new PostData();
}

NotificationData loadNotification(String notificationID) {
  return null; //new NotificationData();
}

List<AssetData> loadAssets(List<String> filters) {

  List<AssetData> assets = List<AssetData>();
  rawAssetsList.forEach((item) {
    assets.add(new AssetData.fromJson(item));
  });

  return assets;
}

List<PostData> loadPosts(List<String> filters) {

  List<PostData> posts = List<PostData>();
  rawPostsList.forEach((item) {
    posts.add(new PostData.fromJson(item));
  });

  return posts;
}

List<NotificationData> loadNotifications(String artistID) {
  return [
    new NotificationData("0", "0", "Kaede updated Grendel in Modeling", DateTime.now(), false),
    new NotificationData("1", "0", "Kaede updated Grendel in Modeling", DateTime.now(), false),
    new NotificationData("2", "0", "Kaede updated Grendel in Modeling", DateTime.now(), false),
    new NotificationData("3", "0", "Kaede updated Grendel in Modeling", DateTime.now(), false),
    new NotificationData("4", "0", "Kaede updated Grendel in Modeling", DateTime.now(), false),
    new NotificationData("5", "0", "Kaede updated Grendel in Modeling", DateTime.now(), false),
    new NotificationData("6", "0", "Kaede updated Grendel in Modeling", DateTime.now(), false),
  ];
}



List rawPostsList = [
  {
    "id": "0",
    "artistID": "KendraGraham",
    "assetID": "H3RB678fFH",
    "contentAPI": "CORY",
    "contentID": "content/A004.png",
    "department": "materials",
    "timestamp": "2018-07-09 20:19:04Z",
    "slackLink": "https://pipelion.slack.com/messages/CCLEGUTJL"
  },
  {
    "id": "1",
    "artistID": "BenDeMann",
    "assetID": "H3RB678fFH",
    "contentAPI": "CORY",
    "contentID": "content/C014.png",
    "department": "cfx",
    "timestamp": "2018-08-06 17:01:33Z",
    "slackLink": "https://pipelion.slack.com/messages/CCLEGUTJL"
  },
  {
    "id": "2",
    "artistID": "CorySivek",
    "assetID": "KJ81LL9RE0",
    "contentAPI": "CORY",
    "contentID": "content/E020.png",
    "department": "vfx",
    "timestamp": "2018-08-08 10:02:01Z",
    "slackLink": "https://pipelion.slack.com/messages/CCLEGUTJL"
  },
  {
    "id": "3",
    "artistID": "CorySivek",
    "assetID": "KJ81LL9RE0",
    "contentAPI": "CORY",
    "contentID": "content/E04.png",
    "department": "lighting",
    "timestamp": "2018-08-08 18:23:11Z",
    "slackLink": "https://pipelion.slack.com/messages/CCLEGUTJL"
  },
  {
    "id": "4",
    "artistID": "HunterTinney",
    "assetID": "XZS13KHU98",
    "contentAPI": "CORY",
    "contentID": "content/C028.png",
    "department": "set_dressing",
    "timestamp": "2018-08-12 01:22:00Z",
    "slackLink": "https://pipelion.slack.com/messages/CCLEGUTJL"
  },
  {
    "id": "5",
    "artistID": "HunterTinney",
    "assetID": "UNR6HF8BFH",
    "contentAPI": "CORY",
    "contentID": "content/H011.png",
    "department": "cfx",
    "timestamp": "2018-09-15 14:09:00Z",
    "slackLink": "https://pipelion.slack.com/messages/CCLEGUTJL"
  },
  {
    "id": "6",
    "artistID": "KendraGraham",
    "assetID": "PERT743561",
    "contentAPI": "CORY",
    "contentID": "content/cloth02.jpg",
    "department": "materials",
    "timestamp": "2018-09-17 18:29:00Z",
    "slackLink": "https://pipelion.slack.com/messages/CCLEGUTJL"
  },
  {
    "id": "7",
    "artistID": "HunterTinney",
    "assetID": "UNR6HF8BFH",
    "contentAPI": "CORY",
    "contentID": "content/B026.png",
    "department": "rigging",
    "timestamp": "2018-09-18 15:49:00Z",
    "slackLink": "https://pipelion.slack.com/messages/CCLEGUTJL"
  },
  {
    "id": "8",
    "artistID": "BenDeMann",
    "assetID": "QG8YUB6JO9",
    "contentAPI": "CORY",
    "contentID": "content/MeadhallAssets.gif",
    "department": "modeling",
    "timestamp": "2018-09-28 11:11:00Z",
    "slackLink": "https://pipelion.slack.com/messages/CCLEGUTJL"
  },
  {
    "id": "9",
    "artistID": "CorySivek",
    "assetID": "QG8YUB6JO9",
    "contentAPI": "CORY",
    "contentID": "content/A008.png",
    "department": "materials",
    "timestamp": "2018-10-02 14:41:00Z",
    "slackLink": "https://pipelion.slack.com/messages/CCLEGUTJL"
  },
  {
    "id": "10",
    "artistID": "HunterTinney",
    "assetID": "H3RB678fFH",
    "contentAPI": "CORY",
    "contentID": "content/B022.png",
    "department": "materials",
    "timestamp": "2018-10-06 12:01:00Z",
    "slackLink": "https://pipelion.slack.com/messages/CCLEGUTJL"
  },
  {
    "id": "11",
    "artistID": "KendraGraham",
    "assetID": "H3RB678fFH",
    "contentAPI": "CORY",
    "contentID": "content/B029.png",
    "department": "rigging",
    "timestamp": "2018-10-08 15:01:00Z",
    "slackLink": "https://pipelion.slack.com/messages/CCLEGUTJL"
  },
  {
    "id": "12",
    "artistID": "CorySivek",
    "assetID": "V97BJH34KH",
    "contentAPI": "CORY",
    "contentID": "content/C002.png",
    "department": "modeling",
    "timestamp": "2018-10-09 16:01:00Z",
    "slackLink": "https://pipelion.slack.com/messages/CCLEGUTJL"
  },
  {
    "id": "13",
    "artistID": "HunterTinney",
    "assetID": "H3RB678fFH",
    "contentAPI": "CORY",
    "contentID": "content/C018.png",
    "department": "materials",
    "timestamp": "2018-10-09 17:31:00Z",
    "slackLink": "https://pipelion.slack.com/messages/CCLEGUTJL"
  }
];

List rawAssetsList = [
  {
    "id": "H3RB678fFH",
    "thumbnail": "thumbnails/Grendel.png",
    "name": "Grendel",
    "postIDs": [
      "0",
      "1",
      "10",
      "11",
      "13"
    ],
    "departments": [
      "visdev",
      "rigging",
      "cfx",
      "modeling",
      "materials"
    ]
  },
  {
    "id": "UNR6HF8BFH",
    "thumbnail": "thumbnails/CookieViking.png",
    "name": "Cookie_Viking",
    "postIDs": [
      "5",
      "7"
    ],
    "departments": [
      "rigging",
      "cfx",
      "modeling",
      "materials"
    ]
  },
  {
    "id": "QG8YUB6JO9",
    "thumbnail": "thumbnails/Meadhall.png",
    "name": "Meadhall",
    "postIDs": [
      "8",
      "9"
    ],
    "departments": [
      "modeling",
      "materials",
      "set_dressing"
    ]
  },
  {
    "id": "KJ81LL9RE0",
    "thumbnail": "thumbnails/E004.png",
    "name": "Shot_E004",
    "postIDs": [
      "2",
      "3"
    ],
    "departments": [
      "animation",
      "vfx",
      "lighting"
    ]
  },
  {
    "id": "V97BJH34KH",
    "thumbnail": "thumbnails/Bed.png",
    "name": "Grendel_Bed",
    "postIDs": [
      "12"
    ],
    "departments": [
      "modeling",
      "materials"
    ]
  },
  {
    "id": "XZS13KHU98",
    "thumbnail": "thumbnails/C009.png",
    "name": "Shot_C009",
    "postIDs": [
      "4"
    ],
    "departments": [
      "set_dressing",
      "animation"
    ]
  },
  {
    "id": "PERT743561",
    "thumbnail": "thumbnails/Blanket.jpg",
    "name": "Couch_Blanket",
    "postIDs": [
      "6"
    ],
    "departments": [
      "modeling",
      "materials"
    ]
  }
];
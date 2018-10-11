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
  return [
    new AssetData("0", "Grendel", "thumbnails/Grendel.png", ["0","1","3"], ["modeling","cfx","rigging"] ),
    new AssetData("1", "Grendel", "thumbnails/Grendel.png", ["0","1","3"], ["modeling","cfx","rigging"] ),
    new AssetData("2", "Grendel", "thumbnails/Grendel.png", ["0","1","3"], ["modeling","cfx","rigging"] ),
    new AssetData("3", "Grendel", "thumbnails/Grendel.png", ["0","1","3"], ["modeling","cfx","rigging"] ),
    new AssetData("4", "Grendel", "thumbnails/Grendel.png", ["0","1","3"], ["modeling","cfx","rigging"] ),
    new AssetData("5", "Grendel", "thumbnails/Grendel.png", ["0","1","3"], ["modeling","cfx","rigging"] ),
    new AssetData("6", "Grendel", "thumbnails/Grendel.png", ["0","1","3"], ["modeling","cfx","rigging"] ),
    new AssetData("7", "Grendel", "thumbnails/Grendel.png", ["0","1","3"], ["modeling","cfx","rigging"] ),
    new AssetData("8", "Grendel", "thumbnails/Grendel.png", ["0","1","3"], ["modeling","cfx","rigging"] )
  ];
}

List<PostData> loadPosts(List<String> filters) {
  return [
    new PostData("0","HunterTinney","Hunter T.","3","A004",ContentAPI.CORY,"content/A004.png","modeling", DateTime.now(),"https://pipelion.slack.com/messages/CCLEGUTJL"),
    new PostData("1","CorySivek","Cory S.","3","B026",ContentAPI.CORY,"content/B026.png","modeling", DateTime.parse("2018-10-10 13:11:00Z"),"https://pipelion.slack.com/messages/CCLEGUTJL"),
    new PostData("2","HunterTinney","Hunter T.","3","A004",ContentAPI.CORY,"content/A004.png","modeling", DateTime.now(),"https://pipelion.slack.com/messages/CCLEGUTJL"),
    new PostData("3","HunterTinney","Hunter T.","3","A004",ContentAPI.CORY,"content/A004.png","modeling", DateTime.now(),"https://pipelion.slack.com/messages/CCLEGUTJL"),
    new PostData("4","HunterTinney","Hunter T.","3","A004",ContentAPI.CORY,"content/A004.png","modeling", DateTime.now(),"https://pipelion.slack.com/messages/CCLEGUTJL")
  ];
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
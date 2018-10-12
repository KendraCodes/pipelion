import 'package:pipelion/mockData.dart';

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

Map<String, AssetData> makeAssetsMap() {
  Map<String, AssetData> assetsMap = Map();
  rawAssetsList.forEach((item) {
    AssetData asset = AssetData.fromJson(item);
    assetsMap.putIfAbsent(asset.id, () => asset);;
  });
}

List<PostData> loadPosts(List<String> filters) {

  List<PostData> posts = List<PostData>();
  rawPostsList.forEach((item) {
    posts.add(new PostData.fromJson(item));
  });

  return posts;
}

Map<String, PostData> makePostsMap() {
  Map<String, PostData> postsMap = Map();
  rawPostsList.forEach((item) {
    PostData post = PostData.fromJson(item);
    postsMap.putIfAbsent(post.id, () => post);
  });

  return postsMap;
}



List<NotificationData> loadNotifications(String artistID) {
  return [
    new NotificationData("0", "0", "Cory S. updated Grendel in Modeling", DateTime.now(), false),
    new NotificationData("1", "0", "Cory S. updated Grendel in Modeling", DateTime.now(), false),
    new NotificationData("2", "0", "Cory S. updated Grendel in Modeling", DateTime.now(), false),
    new NotificationData("3", "0", "Cory S. updated Grendel in Modeling", DateTime.now(), false),
    new NotificationData("4", "0", "Cory S. updated Grendel in Modeling", DateTime.now(), false),
    new NotificationData("5", "0", "Cory S. updated Grendel in Modeling", DateTime.now(), false),
    new NotificationData("6", "0", "Cory S. updated Grendel in Modeling", DateTime.now(), false),
  ];
}

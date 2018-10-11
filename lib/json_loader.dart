import 'model.dart';

AssetData loadAsset(String assetID) {
  return new AssetData();
}

PostData loadPost(String postID) {
  return new PostData();
}

NotificationData loadNotification(String notificationID) {
  return new NotificationData();
}

List<AssetData> loadAssets(List<String> filters) {
  return [
    new AssetData(),
    new AssetData(),
    new AssetData()
  ];
}

List<PostData> loadPosts(List<String> filters) {
  return [
    new PostData(),
    new PostData(),
    new PostData()
  ];
}

Map<String, NotificationData> loadNotifications() {
  return [
    new NotificationData(),
    new NotificationData(),
    new NotificationData()
  ];
}
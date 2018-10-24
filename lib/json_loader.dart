import 'package:pipelion/mockData.dart';
import 'package:http/http.dart' as http;
import 'model.dart';
import 'dart:convert';

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
    //print("$item");
    assets.add(new AssetData.fromJson(item));
  });

  return assets;
}

Future<List<String>> getDepartments() async {
  final response = await http.get('http://10.37.199.17:8113/get/departments');
  if (response.statusCode == 200) {
        return List<String>.from(json.decode(response.body));
  } else {
        return List<String>();
  }
}

//Map<String,dynamic> queryServer(String query) {
//    Future<http.Response> response = http.get(query);
//    if (response.statusCode == 200) {
//      return json.decode(response.body);
//    }
//    return new Map<String,dynamic>();
//  }

Map<String, AssetData> makeAssetsMap() {
  Map<String, AssetData> assetsMap = Map();
  rawAssetsList.forEach((item) {
    AssetData asset = AssetData.fromJson(item);
    assetsMap.putIfAbsent(asset.id, () => asset);
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

  List<NotificationData> notifications = List<NotificationData>();
  rawNotificationsList.forEach((item) {
    notifications.add(NotificationData.fromJson(item));
  });
  return notifications;
}

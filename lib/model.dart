library viewModel;
import 'package:flutter/material.dart';
import 'json_loader.dart';
import 'main.dart';

enum ContentAPI {
  CORY, VIMEO, SLACK, SKETCHFAB
}

ContentAPI makeContentApiFromString(String apiStr) {

  switch (apiStr.toLowerCase()) {
    case "cory":
      return ContentAPI.CORY;
    case "vimeo":
      return ContentAPI.VIMEO;
    case "slack":
      return ContentAPI.SLACK;
    case "sketchfab":
      return ContentAPI.SKETCHFAB;
    default:
      return ContentAPI.CORY;
  }
}

var viewModel = new ViewModel();

class ViewModel { 

  List<PostData> _posts;
  List<AssetData> _assets;
  List<NotificationData> _notifications;
  List<PostData> _focusedPosts;

  ViewModel() {
    _notifications = new List<NotificationData>();
    _posts = new List<PostData>();
    _assets = new List<AssetData>();
    _focusedPosts = new List<PostData>();
  }

  void populatePosts(List<String> filters) {
    _posts = loadPosts(filters);
  }

  void populateFocusedPosts(String filter) {
    List<String> filters = [filter];
    _focusedPosts = loadPosts(filters);
  }

  void populateAssets(List<String> filters) {
    _assets = loadAssets(filters);
  }

  void populateNotifications(String userID) {
    _notifications = loadNotifications(userID);
  }

  List<PostData> get posts => _posts;
  List<AssetData> get assets => _assets;
  List<NotificationData> get notifications => _notifications;
  List<PostData> get focusedPosts => _focusedPosts;

}

class PostData {
  String _id;
  String _artistID;
  String _artistName;
  String _assetID;
  String _assetName;
  ContentAPI _contentAPI;
  String _content;
  String _department;
  DateTime _timestamp;
  String _slackLink;
  String _slackMessage;

  PostData(String id, String artistID, String artistName, String assetID, String assetName, ContentAPI contentAPI, 
        String content, String department, DateTime timestamp, String slackLink, String slackMessage) {
    _id = id;
    _artistID = artistID;
    _artistName = artistName;
    _assetID = assetID;
    _assetName = assetName;
    _contentAPI = contentAPI;
    _content = content;
    _department = department;
    _timestamp = timestamp;
    _slackLink = slackLink;
  }

  PostData.fromJson(Map item) {
    _id = item["id"];
    _artistID = item["artistID"];
    _artistName = item["artistName"];
    _assetID = item["assetID"];
    _assetName = item["assetName"];
    _contentAPI = makeContentApiFromString(item["contentAPI"]);
    _content = item["contentID"];
    _department = item["department"];
    _timestamp = DateTime.parse(item["timestamp"]);
    _slackLink = item["slackLink"];
    _slackMessage = item["slackMessage"];
  }

  String get id => _id;
  String get artistID => _artistID;
  String get artistName => _artistName;
  String get assetID => _assetID;
  String get assetName => _assetName;
  ContentAPI get contentAPI => _contentAPI;
  String get content => _content;
  String get department => _department;
  DateTime get timestamp => _timestamp;
  String get slackLink => _slackLink;
  String get slackMessage => _slackMessage;
}

class AssetData {
  String _id;
  String _name;
  String _thumbnail;
  List<String> _postIDs;
  List<String> _departments;

  AssetData(String id, String name, String thumbnail, List<String> postIDs, List<String> departments) {
    _id = id;
    _name = name;
    _thumbnail = thumbnail;
    _postIDs = postIDs;
    _departments = departments;
  }

  AssetData.fromJson(Map item) {
    _id = item["id"];
    _name = item["name"];
    _thumbnail = item["thumbnail"];
    _postIDs = item["postIDs"];
    _departments = item["departments"];
  }

  String get id => _id;
  String get name => _name;
  String get thumbnail => _thumbnail;
  List<String> get postIDs => _postIDs;
  List<String> get departments => _departments;
  
}

class NotificationData {
  String _id;
  String _postID;
  String _message;
  DateTime _timestamp;
  bool _isSeen;

  NotificationData(String id, String postID, String message, DateTime timestamp, bool isSeen) {
    _id = id;
    _postID = postID;
    _message = message;
    _timestamp = timestamp;
    _isSeen = isSeen;
  }

  String toString() {
    return _message;
  }

  bool get clicked => _isSeen;
  DateTime get timestamp => _timestamp;
}
library viewModel;
import 'package:flutter/material.dart';
import 'json_loader.dart';
import 'main.dart';

enum ContentAPI {
  CORY, VIMEO, SLACK, SKETCHFAB
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
  String _assetID;
  ContentAPI _contentAPI;
  String _content;
  String _department;
  DateTime _timestamp;
  String _slackLink;

  PostData(String id, String artistID, String assetID, ContentAPI contentAPI, String content, String department, DateTime timestamp, String slackLink) {
    _id = id;
    _artistID = artistID;
    _assetID = assetID;
    _contentAPI = contentAPI;
    _content = content;
    _department = department;
    _timestamp = timestamp;
    _slackLink = slackLink;
  }

  String get id => _id;
  String get artistID => _artistID;
  String get assetID => _assetID;
  ContentAPI get contentAPI => _contentAPI;
  String get content => _content;
  String get department => _department;
  DateTime get timestamp => _timestamp;
  String get slackLink => _slackLink;
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
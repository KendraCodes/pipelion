library viewModel;
import 'package:flutter/material.dart';
import 'json_loader.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


enum ContentAPI {
  CORY, CORY_VIDEO, VIMEO, SLACK, SKETCHFAB
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
    case "cory_video":
      return ContentAPI.CORY_VIDEO;
    default:
      return ContentAPI.CORY;
  }
}

var viewModel = new ViewModel();

class ViewModel { 

  String ip_address = "http://35.161.135.112:8113";

  Function setMainListDirty;

  State<StatefulWidget> _homeWidget;
  List<PostData> _posts;
  List<AssetData> _assets;
  List<NotificationData> _notifications;
  List<PostData> _focusedPosts;
  List<String> _watchedAssets;
  String _postSearchTerm = "";
  String _assetSearchTerm = "";
  String _currentArtist;

  ViewModel() {
    _notifications = new List<NotificationData>();
    _posts = new List<PostData>();
    _assets = new List<AssetData>();
    _focusedPosts = new List<PostData>();
    _watchedAssets = new List<String>();
    _currentArtist = "KendraGraham";
  }

  void initialize(State<StatefulWidget> homeWidget) {
    _homeWidget = homeWidget;
    getModelData(_homeWidget);
  }

  Future<void> getModelData(State<StatefulWidget> statefulWidget) async {
    await getWatchedAssets();
    await populateAssets([]);
    await populatePosts([]);
    await populateNotifications();
    if (statefulWidget != null) {
      statefulWidget.setState((){});
    }
  }

  Future<void> getWatchedAssets() async {
    final response = await http.get('http://35.161.135.112:8113/artists/watching/' + _currentArtist);
    if (response.statusCode == 200) {
        _watchedAssets = List<String>.from(json.decode(response.body));
      } 
  }

  Future<void> setWatchedAssets(String assetID, bool isWatching) async {
    final response = await http.post('http://35.161.135.112:8113/artists/watching/set', 
      body: json.encode({"artistID" : "KendraGraham", "assetID": assetID, "watching": isWatching}));
    if (response.statusCode == 200) {
        print("Success set Watched");
      } 
  }

  Future<void> setSeenNotification(String notificationID, bool isSeen) async {
    final response = await http.post('http://35.161.135.112:8113/notifications/update/' + _currentArtist, 
      body: json.encode({"notificationID" : notificationID, "isRead": isSeen}));
    if (response.statusCode == 200) {
        print("Success set notification seen");
      } 
  }

  Future<void> emptyList(Page page) async {
    if (page == Page.assets) {
      _assets.clear();
      if (setMainListDirty != null) {
        setMainListDirty();
      }
    } else if (page == Page.posts) {
      _posts.clear();
      if (setMainListDirty != null) {
        setMainListDirty();
      }
    }
  }

  Future<void> populatePosts(List<String> filters) async {
    filter(Page.posts, []);
  }

  Future<void> populateFocusedPosts(String filter) async {
    List<String> filters = [filter];
    final response = await http.get('http://35.161.135.112:8113/focusedPosts');
    if (response.statusCode == 200) {
        List<Map> listPosts = List<Map>.from(json.decode(response.body));
        for (Map post in listPosts) {
          _posts.add(PostData.fromJson(post));
        }
      } 
    if (setMainListDirty != null) {
      setMainListDirty();
    }
  }

  Future<void> populateAssets(List<String> filters) async {
    filter(Page.assets, []);
  }

  Future<void> populateNotifications() async {
    final response = await http.get('http://35.161.135.112:8113/notifications/get/' + _currentArtist);
    if (response.statusCode == 200) {
        List<Map> listNotifications = List<Map>.from(json.decode(response.body));
        for (Map notification in listNotifications) {
          _notifications.add(NotificationData.fromJson(notification));
        }
      } 
  }

  Future<void> filter(Page currentPage, List<Filter> filters) async {
    List<String> httpFilters = [];
    for(Filter filter in filters) {
      if (filter.filtered) {
        httpFilters.add(filter.name);
      }
    }

    switch(currentPage) {
      case Page.assets:
        _assets.clear();
        if (setMainListDirty != null) {
          setMainListDirty();
        }
        if (_assetSearchTerm == "") {
          final response = await http.post('http://35.161.135.112:8113/assets', body: json.encode({"departmentFilters" : httpFilters}));
          if (response.statusCode == 200) {
            List<Map> listAssets = List<Map>.from(json.decode(response.body));
            for (Map asset in listAssets) {
              _assets.add(AssetData.fromJson(asset));
            }
          }
        } else {
          final response = await http.post('http://35.161.135.112:8113/assets', body: json.encode({"departmentFilters" : httpFilters, "searchTerm":_assetSearchTerm}));
          if (response.statusCode == 200) {
            List<Map> listAssets = List<Map>.from(json.decode(response.body));
            for (Map asset in listAssets) {
              _assets.add(AssetData.fromJson(asset));
            }
          }
        }
        
      break;
      case Page.notifications:

      break;
      case Page.posts:
        _posts.clear();
        if (setMainListDirty != null) {
          setMainListDirty();
        }
        if (_postSearchTerm == "") {
          final response = await http.post('http://35.161.135.112:8113/posts', body: json.encode({"departmentFilters" : httpFilters}));
          if (response.statusCode == 200) {
            List<Map> listPosts = List<Map>.from(json.decode(response.body));
            for (Map post in listPosts) {
              _posts.add(PostData.fromJson(post));
            }
          } 
        } else {
          final response = await http.post('http://35.161.135.112:8113/posts', body: json.encode({"departmentFilters" : httpFilters, "searchTerm":_postSearchTerm}));
          if (response.statusCode == 200) {
            List<Map> listPosts = List<Map>.from(json.decode(response.body));
            for (Map post in listPosts) {
              _posts.add(PostData.fromJson(post));
            }
          }
        }
        
      break;
    }
    
    if (setMainListDirty != null) {
      setMainListDirty();
    }
    
  }

  List<PostData> get posts => _posts;
  List<AssetData> get assets => _assets;
  List<NotificationData> get notifications => _notifications;
  List<PostData> get focusedPosts => _focusedPosts;

  String get postSearchTerm => _postSearchTerm;
  String get assetSearchTerm => _assetSearchTerm;
  set postSearchTerm(String searchTerm) {
    _postSearchTerm = searchTerm;
  }
  set assetSearchTerm(String searchTerm) {
    _assetSearchTerm = searchTerm;
  }

  bool isWatched(String assetID) {
    return _watchedAssets.contains(assetID);
  }

  void toggleNotification(String assetID) {
    bool isWatching = _watchedAssets.contains(assetID);
    if (isWatching) {
      _watchedAssets.remove(assetID);
    } else {
      _watchedAssets.add(assetID);
    }
    setWatchedAssets(assetID, !isWatching);
    setMainListDirty();
  }

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
    _postIDs = List<String>.from(item["postIDs"]);
    _departments = List<String>.from(item["departments"]);
  }

  String get id => _id;
  String get name => _name;
  String get thumbnail => _thumbnail;
  List<String> get postIDs => _postIDs;
  List<String> get departments => _departments;
  
}

class NotificationData {
  String _id;
  String _artistID;
  String _postID;
  String _message;
  DateTime _timestamp;
  bool _isSeen;

  NotificationData(String id, String artistID, String postID, String message, DateTime timestamp, bool isSeen) {
    _id = id;
    _artistID = artistID;
    _postID = postID;
    _message = message;
    _timestamp = timestamp;
    _isSeen = isSeen;
  }

  NotificationData.fromJson(Map item) {
    _id = item["id"];
    _artistID = item["artistID"];
    _postID = item["postID"];
    _message = item["message"];
    _timestamp = DateTime.parse(item["timestamp"]);
    _isSeen = item["isSeen"];
  }

  String toString() {
    return _message;
  }

  String get id => _id;

  String get artistID => _artistID;

  bool get isSeen => _isSeen;
  void setIsSeen() {
    _isSeen = true;
    viewModel.setSeenNotification(_id, _isSeen);
  }

  DateTime get timestamp => _timestamp;

  String get postID => _postID;

  String get message => _message;
}
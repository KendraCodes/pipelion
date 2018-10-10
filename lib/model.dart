import 'package:flutter/material.dart';
import 'main.dart';

enum ContentAPI {
  Cory, Vimeo, Slack, Sketchfab
}

class ModelManager {
  Map<String, ArtistData> artists;
  Map<String, PostData> posts;
  Map<String, AssetData> assets;

  ArtistData GetArtist(String artist_id) {
    if (artists.containsKey(artist_id)) {
      return artists[artist_id];
    } else {
      ArtistData artist = loadArtist(artist_id);
      if (artist) {
        artists[artist_id] = artist;
      }
    }
  }  
}

class ArtistData {
  String _id;
  String _name;
  String _thumbnail;
}

class PostData {
  String _id;
  String _artist_id;
  String _asset_id;
  ContentAPI _content_api;
  String _content;
  String _department;
  DateTime timestamp;
  String _slack_link;

}

class AssetData {
  String _id;
  String _name;
  String _thumbnail;
  List<String> _posts_ids;
  List<String> _departments;
  
}

class NotificationData {
  String _artist;
  String _department;
  String _asset;
  DateTime _updated;
  bool _clicked;

  NotificationData(bool isClicked) {
    _artist = "Kaede";
    _department = "modeling";
    _asset = "Delilah";
    _updated = new DateTime(2018, 10, 8, 15, 25, 24, 0, 0);
    _clicked = isClicked;
  }

  String toString() {
    return _artist + " updated " + _asset + " in " + _department;
  }

  bool get clicked => _clicked;

}
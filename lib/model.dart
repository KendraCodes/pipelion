import 'package:flutter/material.dart';
import 'main.dart';

class CardModel {
  
}

class PostData extends CardModel {
  
}

class AssetData extends CardModel {
  
}

class NotificationData extends CardModel {
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
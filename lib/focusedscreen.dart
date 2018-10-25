import 'package:flutter/material.dart';
import 'cards.dart';
import 'main.dart';
import 'model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FocusedScreen extends StatefulWidget {

  FocusedScreen(DataType dataType, String data, String niceName) {
    _dataType = dataType;
    _data = data;
    _niceName = niceName;
  }
  DataType _dataType;
  String _data;
  String _niceName;

  FocusedScreenState myState;

  @override
  State<StatefulWidget> createState() {
    myState = new FocusedScreenState();
    return myState;
  }
}

class FocusedScreenState extends State<FocusedScreen> {
  FocusedScreenState() {
    _posts = List<PostData>();
  }
  List<PostData> _posts;

  @override
  initState() {
    super.initState();
    filterPosts();
  }

  Future<void> filterPosts() async {
    if (!mounted) {
      return;
    }
    // Clear old posts
    setState((){
      _posts.clear();
    });

    String url;
    String body;
    switch(widget._dataType) {
      case DataType.artist:
      url = viewModel.ip_address + "/posts";
      body = json.encode({"artistFilters" : [widget._data]});
      break;
      case DataType.asset:
      url = viewModel.ip_address + "/posts";
      body = json.encode({"assetFilters" : [widget._data]});
      break;
      case DataType.department:
      url = viewModel.ip_address + "/posts";
      body = json.encode({"departmentFilters" : [widget._data]});
      break;
      case DataType.post:
      url = viewModel.ip_address + "/posts/" + widget._data;
      break;
    }

    if (widget._dataType == DataType.post) {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map post = json.decode(response.body);
        _posts.add(PostData.fromJson(post));
      }
    } else {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        List<Map> listPosts = List<Map>.from(json.decode(response.body));
        for (Map post in listPosts) {
          _posts.add(PostData.fromJson(post));
        }
      }
    }

    if (!mounted) {
      return;
    }
    setState((){});
    
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SafeArea(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Expanded(
                      child: new ListView.builder(
                      itemCount: _posts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new PostCard(_posts[index]);
                      },
                    )
                  )
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(title:Text(widget._niceName)),
      );
  }
}
import 'package:flutter/material.dart';
import 'model.dart';
import 'main.dart';
import 'dart:io';
import 'dart:convert';
import 'json_loader.dart';
import 'dart:async';
import 'package:video_player/video_player.dart';
import 'package:flutter/gestures.dart';
import 'package:chewie/chewie.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;
import 'videoplayer.dart';
import 'focusedscreen.dart';
import 'focusedsketchfab.dart';

class AssetCard extends StatefulWidget {

  AssetCard(AssetData n) {
    data = n;
  }

  AssetData data;

  @override
  State<StatefulWidget> createState() {
    return new AssetCardState(data);
  }

}

class AssetCardState extends State<AssetCard> {

  AssetCardState(this.n);
  AssetData n;

  CachedNetworkImage getAssetThumbnail() {
    return CachedNetworkImage(
      imageUrl: "http://students.cs.byu.edu/~csivek/pipelion/" + n.thumbnail,
      placeholder: new Container(height:100.0, width:100.0),
      errorWidget: new Icon(Icons.error),
      width:100.0,
      height:100.0);
  }

  Widget getDepartmentTags() {
    String result = "Tags: ";
    for(int i = 0; i < n.departments.length && i < 3; i++) {
      result += n.departments[i];
      if (i < 2) {
        result += ", ";
      }
    }
    return new Text(result, style: TextStyle(fontSize:10.0));
  }

  Icon getNotificationIcon() {
    if (viewModel.isWatched(n.id)){
      return Icon(Icons.notifications, color: Colors.deepPurple,);
    } else {
      return Icon(Icons.add_alert, color: Colors.grey,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FocusedScreen(DataType.asset, n.id, n.name)),
            );
          },
        child: Padding(padding: EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
            child: Row(
            children: <Widget>[
            getAssetThumbnail(),
            Padding(padding: EdgeInsets.only(right:8.0)),
              Container(
              height:100.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [Text(n.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
                Text("Last updated [] ago")]),
                Row(mainAxisAlignment:MainAxisAlignment.start, children: <Widget>[getDepartmentTags()])
              ]),)])),
            IconButton(
              icon: getNotificationIcon(),
              iconSize: 32.0, 
              tooltip: 'Toggle Notifications for this Asset',
              onPressed: () { setState(() {viewModel.toggleNotification(n.id);}); },
            )
          ]
        )))
    );
  }
}




class PostCard extends StatefulWidget {

  PostCard(PostData n) {
    data = n;
  }

  PostData data;

  @override
  State<StatefulWidget> createState() {
    return new PostCardState(data);
  }

}

class PostCardState extends State<PostCard> {

  PostCardState(PostData n) {
    this.n = n;
  }
  PostData n;
  VideoPlayerController _controller;

  void initState() {
    super.initState();
    //initializeController();
  }

  initializeController() async {
    _controller.dispose();
    _controller = VideoPlayerController.network(
      'http://students.cs.byu.edu/~csivek/pipelion/' + n.content,
    );
    await _controller.initialize().then((_) {
      setState((){});
    });
  }

  Image getSlackImage() {
    return Image.asset("assets/images/slack.png", width:50.0, height:50.0);
  }

  Widget getSketchFabThumbnail(String uid) {
    return FutureBuilder<http.Response>(
      future: http.get('https://api.sketchfab.com/v3/models/' + uid),
      builder: (context, response) {
        if (response.hasData) {
          String result = "";
          if (response.data.statusCode == 200) {
            Map<String, dynamic> data = json.decode(response.data.body);
            if(data.keys.contains("thumbnails")) {
              Map<String, dynamic> thumbnails = data["thumbnails"];
              if(thumbnails.keys.contains("images")) {
                var imagesFromJSON = thumbnails["images"] as List;
                var images = imagesFromJSON.map((i) => i).toList();
                print(images.runtimeType);
                if (images.length > 0 && images[0].keys.contains("url")) {
                    result = images[0]["url"];
                    return CachedNetworkImage(
                      imageUrl: result,
                      placeholder: new FittedBox(fit:BoxFit.contain, child:Container(width:500.0,height:500.0)),
                      errorWidget: new Icon(Icons.error),
                      fit:BoxFit.contain);
                }
              }
          }
          
        }
        } else if (response.hasError) {
          return new Icon(Icons.error);
        }   // By default, show a loading spinner
        return new FittedBox(fit:BoxFit.contain, child:Container(width:500.0,height:500.0));
      }
    );
  }

  CachedNetworkImage getUserThumbnail() {
    return CachedNetworkImage(
      imageUrl: "http://students.cs.byu.edu/~csivek/pipelion/user_thumbnails/" + n.artistID + ".png",
      placeholder: new FittedBox(fit:BoxFit.contain, child:Container(width:30.0,height:30.0)),
      errorWidget: new Icon(Icons.error),
      width:30.0,
      height: 30.0);
  }


  
  Widget getContent() {
    switch(n.contentAPI) {
      case ContentAPI.CORY: 
        return CachedNetworkImage(
          imageUrl: "http://students.cs.byu.edu/~csivek/pipelion/" + n.content,
          placeholder: new FittedBox(fit:BoxFit.contain, child:Container(width:500.0,height:500.0)),
          errorWidget: new Icon(Icons.error),
          fit:BoxFit.contain);
        break;
      case ContentAPI.CORY_VIDEO:
       return new NetworkPlayerLifeCycle(
                    "http://students.cs.byu.edu/~csivek/pipelion/" + n.content,
                    (BuildContext context, VideoPlayerController controller) =>
                    //AspectRatioVideo(controller)
                  Chewie(controller, autoPlay: true, looping: true),
        );
        break;
      case ContentAPI.SKETCHFAB:
      
        //DrawWebView(new Rect.fromLTWH(0.0,0.0,MediaQuery.of(context).size.width, 300.0), MediaQuery.of(context).size.width, 300.0);
        return GestureDetector(
          onTap: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FocusedSketchfab(n)),
                );
            },
          child: Stack(alignment: Alignment(0.0,0.0),children: <Widget> [getSketchFabThumbnail(n.content), Opacity(opacity:0.75,child:Image.asset("assets/images/sketchfab.png", width:100.0, height:100.0, ))]));

        break;
      case ContentAPI.SLACK: 
        break;
      case ContentAPI.VIMEO: 
        break;
    }
  }

  String getAssetName(String assetID) {
    return "Grendel";
  }

  Icon getNotificationIcon() {
    if (viewModel.isWatched(n.assetID)){
      return Icon(Icons.notifications, color: Colors.deepPurple,);
    } else {
      return Icon(Icons.add_alert, color: Colors.grey,);
    }
  }

  _launchURL() async {
    if (await canLaunch(n.slackLink)) {
      await launch(n.slackLink);
    } else {
      throw "Could not launch";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(padding:EdgeInsets.symmetric(horizontal:8.0,vertical:2.0),
    child: Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal:8.0, vertical:4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(padding:EdgeInsets.symmetric(vertical:4.0),
            child:Row(
              children: <Widget>[
                getUserThumbnail(),
                Padding(padding:EdgeInsets.only(left:8.0)),
                Expanded(
                child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FocusedScreen(DataType.artist, n.artistID, n.artistName)),
                          );
                        },
                        child:
                          Text(
                            n.artistName,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.bold),
                            ),
                      ),
                      Text(
                        " posted",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 13.0),
                        ),
                      Flexible(
                        child: Container(
                          
                          child: GestureDetector(
                        onTap: () {Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FocusedScreen(DataType.asset, n.assetID, n.assetName)),
                          );
                        },
                        child: Text(
                            " " + n.assetName,
                            softWrap: false,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.fade,
                            style: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.bold),
                            )
                          ))
                      ),
                      Text(
                          " in ",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black, fontSize: 13.0, ),
                        ),
                      GestureDetector(
                        onTap: () {Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FocusedScreen(DataType.department, n.department, n.department)),
                          );
                        },
                        child: Text(
                          " " + n.department,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.bold),
                        ))
                      ],
                  )),
                ],
              ),),
            Padding(padding: EdgeInsets.symmetric(vertical:4.0),
              child: Row(mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(4.0),
                      child: getContent()
                      ),
                ),
              ]),
            ),
            Padding(padding:EdgeInsets.symmetric(vertical:4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                  onTap: () { setState(() {viewModel.toggleNotification(n.assetID);}); },
                  child: Container(
                  width: 30.0,
                  height: 30.0,
                  child: Center(
                  child: getNotificationIcon()
                  ))),
                  Text(timeago.format(n.timestamp)),
                ]
              )
              ),
            Padding(padding:EdgeInsets.symmetric(vertical:4.0),
            child:Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                child:Container(
                    padding:EdgeInsets.all(14.0),
                    child:Text(
                      n.slackMessage,
                      style: TextStyle(color: Colors.black, fontSize: 15.0),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      ),
                    height:75.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      border: new Border.all(width: 1.0, color: Colors.black12),
                    ),
                ),
                ),
                Padding(padding:EdgeInsets.only(right:8.0)),
                ButtonTheme(
                  minWidth: 75.0,
                  height: 75.0,
                  padding:EdgeInsets.all(0.0),
                  child: RaisedButton(
                    onPressed:_launchURL,
                    color:Colors.white,
                    elevation: 5.0,
                    child: Column(children: <Widget>[ getSlackImage(), Text("Go to Slack")]),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0))
                  ),
                ),
              ],
            )),
            
          ],
        ),
    )));
  }
}


class NotificationCard extends StatefulWidget {

  NotificationCard(NotificationData n) {
    data = n;
  }

  NotificationData data;

  @override
  State<StatefulWidget> createState() {
    return new NotificationCardState(data);
  }

}

class NotificationCardState extends State<NotificationCard> {

  NotificationCardState(this.n);
  NotificationData n;

  CachedNetworkImage getUserThumbnail() {
    return CachedNetworkImage(
      imageUrl: "http://students.cs.byu.edu/~csivek/pipelion/user_thumbnails/" + n.artistID + ".png",
      placeholder: new Container(width:50.0,height:50.0),
      errorWidget: new Icon(Icons.error),
      width:50.0,
      height: 50.0);
  }

  @override
  Widget build(BuildContext context) {
    Color myColor = n.isSeen ? Colors.white.withOpacity(0.0) : Colors.green[100].withOpacity(0.5);
    return Container(
//        margin: const EdgeInsets.all(15.0),
//        padding: const EdgeInsets.all(3.0),
      decoration: new BoxDecoration(
        color: myColor,
        border: new  Border(bottom: new BorderSide(color: Theme.of(context).dividerColor)),
      ),
//        color: Colors.white,
      child: InkWell(
      onTap: () {
        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FocusedScreen(DataType.post, n.postID, n.message)),
            );
        },
        child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal:8.0),
        leading: Container(width: 50.0,child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[getUserThumbnail()])),
        title:Text(n.toString(),style: new TextStyle(fontSize: 14.0),),
        subtitle:  Text(timeago.format(n.timestamp),style: new TextStyle(fontSize: 12.0),),
        )
    )
    );
  }
}


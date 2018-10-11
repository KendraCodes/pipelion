import 'package:flutter/material.dart';
import 'model.dart';
import 'main.dart';
import 'dart:io';
import 'json_loader.dart';
import 'package:flutter/gestures.dart';


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

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: const Icon(Icons.album),
            title: const Text('The Enchanted Nightingale'),
            subtitle: const Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
          ),
          new ButtonTheme.bar( // make buttons use the appropriate styles for cards
            child: new ButtonBar(
              children: <Widget>[
                new FlatButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () { /* ... */ },
                ),
                new FlatButton(
                  child: const Text('LISTEN'),
                  onPressed: () { /* ... */ },
                ),
              ],
            ),
          ),
        ],
      ),
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

  Image getSlackImage() {
    return Image.asset("assets/images/slack.png", width:50.0, height:50.0);
  }

  Image getUserThumbnail() {
    return Image.network("http://students.cs.byu.edu/~csivek/pipelion/user_thumbnails/" + n.artistID + ".png", width:30.0, height: 30.0);
  }
  
  Widget getContent() {
    switch(n.contentAPI) {
      case ContentAPI.CORY: 
        return Image.network("http://students.cs.byu.edu/~csivek/pipelion/" + n.content, fit:BoxFit.contain);
        break;
      case ContentAPI.SKETCHFAB: 
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

  @override
  Widget build(BuildContext context) {
    return new Card(
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
                      Text(
                        n.artistID,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.bold),
                        ),
                      Text(
                        " posted",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 13.0),
                        ),
                      Flexible(
                        child: Container(
                          child: Text(
                            " " + getAssetName(n.assetID),
                            softWrap: false,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.fade,
                            style: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.bold),
                            )
                          )
                      ),
                      Text(
                          " in ",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black, fontSize: 13.0, ),
                        ),
                      Text(
                          " " + n.department,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                  )),
                ],
              ),),
            Padding(
              padding: EdgeInsets.symmetric(vertical:4.0),
              child: Row(mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: getContent(),
                ),
              ]),
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
                      "Here's a slack message with an update about how the asset is doing. Isn't that great? Here's a slack message with an update about how the asset is doing. Isn't that great? Here's a slack message with an update about how the asset is doing. Isn't that great?Here's a slack message with an update about how the asset is doing. Isn't that great? Here's a slack message with an update about how the asset is doing. Isn't that great?",
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
                    color:Colors.white,
                    elevation: 5.0,
                    onPressed: () {},
                    child: Column(children: <Widget>[ getSlackImage(), Text("Go to Slack")]),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0))
                  ),
                ),
              ],
            )),
            Row(),
          ],
        ),
    ));
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

  @override
  Widget build(BuildContext context) {
    BorderSide blackLine = new BorderSide(
      color: Colors.black54,
      width: 1.0,
    );
    Color myColor = n.clicked ? Colors.white : Theme.of(context).bottomAppBarColor;
    return Container(
//        margin: const EdgeInsets.all(15.0),
//        padding: const EdgeInsets.all(3.0),
      decoration: new BoxDecoration(
        color: myColor,
        border: new Border(
          bottom: blackLine,
          top: new BorderSide(width:0.0,),
        ),
      ),
//        color: Colors.white,
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            n.toString(),
            style: new TextStyle(fontSize: 14.0),
          ),
        ]
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'model.dart';
import 'main.dart';

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

  PostCardState(this.n);
  PostData n;

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


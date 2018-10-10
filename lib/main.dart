import 'package:flutter/material.dart';
import 'top_bar.dart';

void main() => runApp(new Pipelion());

enum Page {
  assets,
  posts,
  notifications
}

final Map pageSearchTerms = {
  Page.assets: "search assets DOESN'T WORK YET",
  Page.posts: "search posts DOESN'T WORK YET",
};

class Pipelion extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'BYU Animation Pipelion',
      theme: new ThemeData(
        primarySwatch: Colors.green,
        backgroundColor: Colors.black12,
        bottomAppBarColor: Colors.green.shade300,
      ),
      home: new MyHomePage(title: 'Pipelion Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  _MyHomePageState() {
    _showFilters = false;
    _currentPage = Page.posts;
    _searchText = "default search text";
    _topBar = new TopBar(_updateSearch);
  }

  bool _showFilters;
  Page _currentPage;
  String _searchText;

  TopBar _topBar;

  void _updateSearch(String searchText) {
    setState(() {
      _searchText = searchText;
    });
  }

  void _onHomeClicked() {
    setState(() {
      _currentPage = Page.posts;
      _topBar.setCurrentPage(_currentPage);
    });
  }

  void _onNotificationsClicked() {
    setState(() {
      _currentPage = Page.notifications;
      _topBar.setCurrentPage(_currentPage);
    });
  }

  void _onAssetsMenuClicked() {
    setState(() {
      _currentPage = Page.assets;
      _topBar.setCurrentPage(_currentPage);
    });
  }


  @override
  Widget build(BuildContext context) {
    EdgeInsets menuButtonsPadding = new EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0);

    return new Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _topBar,
            new Text(
              _searchText,
              style: Theme.of(context).textTheme.display1,
            ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Theme.of(context).bottomAppBarColor,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: menuButtonsPadding,
                child: IconButton(icon: Icon(Icons.menu), onPressed: _onAssetsMenuClicked,),
              ),
              Padding(
                padding: menuButtonsPadding,
                child: IconButton(icon: Icon(Icons.home), onPressed: _onHomeClicked,),
              ),
              Padding(
                padding: menuButtonsPadding,
                child: IconButton(icon: Icon(Icons.notifications), onPressed: _onNotificationsClicked,),
              )
            ],
          ),
        ),
      ),

    );
  }
}

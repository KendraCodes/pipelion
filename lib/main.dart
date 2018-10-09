import 'package:flutter/material.dart';

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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  _MyHomePageState() {
    _showFilters = false;
    _currentPage = Page.posts;
    _topBar = new TopBar();
  }

  bool _showFilters;
  Page _currentPage;

  TopBar _topBar;

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
//            new Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
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

class TopBar extends StatefulWidget {

  void setCurrentPage(Page page) {
    myState._setCurrentPage(page);
  }

  TopBarState myState;

  @override
  State<StatefulWidget> createState() {
    myState = new TopBarState();
    return myState;
  }
}

class TopBarState extends State<TopBar> {

  TopBarState() {
    currentPage = Page.posts;
  }

  void _setCurrentPage(Page page) {
    setState(() {
      currentPage = page;
    });
  }

  Page currentPage;
  String searchText = "";

  void _onSearch() {}

  @override
  Widget build(BuildContext context) {
    if (currentPage == Page.notifications) {
      return Container(
//        margin: const EdgeInsets.all(15.0),
//        padding: const EdgeInsets.all(3.0),
          decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border(
              bottom: new BorderSide(
                color: Colors.black,
                width: 1.0,
              )
            ),
          ),
//        color: Colors.white,
        height: 70.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Notifications",
              style: new TextStyle(fontSize: 16.0),
            ),
          ]
        ),
      );
    }
    else {
      return Container(
        padding: EdgeInsets.all(8.0),
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 3.0, // has the effect of softening the shadow
              spreadRadius: -8.0, // has the effect of extending the shadow
              offset: new Offset(2.0, 2.0)
            )
          ]
        ),
        child: Center(
          child: Container(
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(new Radius.circular(3.0)),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: Icon(Icons.search),
                ),
                Text(pageSearchTerms[currentPage]),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 2.0, 0.0),
                  child: IconButton(
                    icon: Icon(Icons.filter_list), onPressed: _onSearch),
                ),
              ]
            ),
          ),
        ),
      );
    }
  }

}

import 'package:flutter/material.dart';
import 'top_bar.dart';
import 'cards.dart';
import 'model.dart';
import 'main_list_view.dart';

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
        selectedRowColor: Colors.green.shade300,
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
  final items = List<NotificationData>.generate(20, (i) => NotificationData(i.toString(), null, "Kaede updated Grendel in Modeling", DateTime.now(), i % 2 == 1));
  _MyHomePageState() {
    viewModel.populateAssets([]);
    viewModel.populatePosts([]);
    viewModel.populateNotifications("");

    _showFilters = false;
    _currentPage = Page.posts;
    _searchText = "default search text";
    _topBar = new TopBar(_updateSearch);
    _mainListView = new MainListView(items);
  }

  bool _showFilters;
  Page _currentPage;
  String _searchText;

  TopBar _topBar;
  MainListView _mainListView;

  void _updateSearch(String searchText) {
    setState(() {
      _searchText = searchText;
    });
  }

  void _onHomeClicked() {
    setState(() {
      _currentPage = Page.posts;
      _topBar.setCurrentPage(_currentPage);
      _mainListView.setCurrentPage(_currentPage);
    });
  }

  void _onNotificationsClicked() {
    setState(() {
      _currentPage = Page.notifications;
      _topBar.setCurrentPage(_currentPage);
      _mainListView.setCurrentPage(_currentPage);
    });
  }

  void _onAssetsMenuClicked() {
    setState(() {
      _currentPage = Page.assets;
      _topBar.setCurrentPage(_currentPage);
      _mainListView.setCurrentPage(_currentPage);
    });
  }

  BoxDecoration getAppBarIconBG(Page page) {
    if(page == _currentPage) {
      return BoxDecoration(gradient: new RadialGradient(radius:0.6, colors: [Colors.white.withOpacity(0.4),Colors.white.withOpacity(0.0)]));
    } else {
      return BoxDecoration();
    }
  }

  Color getAppBarIconColor(Page page) {
    if(page == _currentPage) {
      return Colors.white;
    } else {
      return Colors.black;
    }
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
                _mainListView,
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
              Container(
                decoration: getAppBarIconBG(Page.assets),
                padding: menuButtonsPadding,
                child: IconButton(icon: Icon(Icons.menu, color: getAppBarIconColor(Page.assets)), onPressed: _onAssetsMenuClicked,),
              ),
              Container(
                decoration: getAppBarIconBG(Page.posts),
                padding: menuButtonsPadding,
                child: IconButton(icon: Icon(Icons.home, color: getAppBarIconColor(Page.posts)), onPressed: _onHomeClicked,),
              ),
              Container(
                decoration: getAppBarIconBG(Page.notifications),
                padding: menuButtonsPadding,
                child: IconButton(icon: Icon(Icons.notifications, color: getAppBarIconColor(Page.notifications)), onPressed: _onNotificationsClicked,),
              )
            ],
          ),
        ),
      ),

    );
  }
}

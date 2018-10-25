import 'package:flutter/material.dart';
import 'appbarsearch.dart';
import 'filterdrawer.dart';
import 'json_loader.dart';
import 'dart:convert';
import 'model.dart';
import 'main_list_view.dart';
import 'package:http/http.dart' as http;
import 'pipelion_asset_box_icons.dart';

void main() => runApp(new Pipelion());

enum Page {
  assets,
  posts,
  notifications
}

enum SearchState {
  idle,
  searching
}

enum DataType {
  artist,
  asset,
  department,
  post
}

class Filter {
  Filter(String name, bool filtered) {
    this.name = name;
    this.filtered = filtered;
  }
  String name;
  bool filtered;
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
  _MyHomePageState() {
    viewModel.initialize(this);

    _showFilters = false;
    _currentPage = Page.posts;
    _searchText = "default search text";
    _searchState = SearchState.idle;
    _appBarSearch = new AppBarSearch(_updateSearch, _onSearchPressed);
    _filterDrawer = new FilterDrawer(_updateFilters, _getFilters);
    _mainListView = new MainListView();

    _initializeFilters();
  }

  bool _showFilters;
  Page _currentPage;
  String _searchText;
  SearchState _searchState;
  List<Filter> _filters = [new Filter("Watched", true), new Filter("Materials", false)];

  AppBarSearch _appBarSearch;
  FilterDrawer _filterDrawer;
  MainListView _mainListView;

  void _updateSearch(String searchText) {
    setState(() {
      _searchText = searchText;
    });
  }

  Future<void> _initializeFilters() async {
    final response = await http.get('http://35.161.135.112:8113/get/departments');
    if (response.statusCode == 200) {
      List<String> departments = List<String>.from(json.decode(response.body));
      print(departments.length);
      _filters = new List<Filter>();
      for (String department in departments){
        print(department);
        _filters.add(new Filter(department,false));
      }
    }
  }

  void _updateFilters(List<Filter> filters) {
    
    viewModel.filter(_currentPage, filters);
    _filterDrawer.myState.setState((){
      _filters = filters;
    });
  }

  List<Filter> _getFilters() {
    return _filters;
  }

  void _onSearchPressed() {
    setState(() {
      if (_searchState == SearchState.idle) {
        _searchState = SearchState.searching;
      } else {
        _searchState = SearchState.idle;
      }
      _appBarSearch.setSearchState(_searchState);
    });
  }

  void _onHomeClicked() {
    setState(() {
      _currentPage = Page.posts;
      _appBarSearch.setCurrentPage(_currentPage);
      _mainListView.setCurrentPage(_currentPage);
    });
  }

  void _onNotificationsClicked() {
    setState(() {
      _currentPage = Page.notifications;
      _appBarSearch.setCurrentPage(_currentPage);
      _mainListView.setCurrentPage(_currentPage);
    });
  }

  void _onAssetsMenuClicked() {
    setState(() {
      _currentPage = Page.assets;
      _appBarSearch.setCurrentPage(_currentPage);
      _mainListView.setCurrentPage(_currentPage);
    });
  }

  BottomAppBar getBottomAppBar() {
    EdgeInsets menuButtonsPadding = new EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0);
      return BottomAppBar(
        child: Container(
          color: Theme.of(context).bottomAppBarColor,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                decoration: getAppBarIconBG(Page.assets),
                padding: menuButtonsPadding,
                child: IconButton(icon: Icon(PipelionAssetBox.box, color: getAppBarIconColor(Page.assets)), onPressed: _onAssetsMenuClicked,),
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
      );
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

  IconButton _getActionButton() {
    switch(_searchState) {
      case SearchState.idle:
      return IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print("touched in idle state");
                _onSearchPressed();
              },
            );
      break;
      case SearchState.searching:
      return IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                print("touched in searching state");
                _onSearchPressed();
              },
            );
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPage == Page.notifications) {
      return new Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.white.withOpacity(0.0),
            child: new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _mainListView,
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(title:_appBarSearch),
        bottomNavigationBar: getBottomAppBar(),
      );
  } else {
    return new Scaffold(
        body: SafeArea(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _mainListView,
                ],
              ),
            ),
          ),
        ),
        drawer: Drawer(child:_filterDrawer),
        appBar: AppBar(title:_appBarSearch, actions: <Widget>[ _getActionButton()]),
        bottomNavigationBar: getBottomAppBar(),
      );
  }
  }
}

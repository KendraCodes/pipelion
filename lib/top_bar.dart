import 'package:flutter/material.dart';
import 'main.dart';

class TopBar extends StatefulWidget {
  TopBar(void Function(String searchText) updateSearch) {
    _parentUpdateSearchText = updateSearch;
  }

  void Function(String searchText) _parentUpdateSearchText;

  void setCurrentPage(Page page) {
    myState._setCurrentPage(page);
  }

  TopBarState myState;

  @override
  State<StatefulWidget> createState() {
    myState = new TopBarState(_parentUpdateSearchText);
    return myState;
  }
}

class TopBarState extends State<TopBar> {

  TopBarState(void Function(String searchText) parentUpdateSearchText) {
    currentPage = Page.posts;
    _parentUpdateSearchText = parentUpdateSearchText;
    _searchCounter = 0;
  }

  void Function(String searchText) _parentUpdateSearchText;
  int _searchCounter;

  void _updateSearchText() {
    setState(() {
      _searchCounter++;
      _parentUpdateSearchText("Clicked Search " + '$_searchCounter' + " times.");
    });
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
          border: new  Border(bottom: new BorderSide(color: Theme.of(context).dividerColor)),
        ),
//        color: Colors.white,
        height: 70.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Notifications",
              style: new TextStyle(fontSize: 20.0),
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
                  child: IconButton(icon: Icon(Icons.search), onPressed: _updateSearchText,),
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

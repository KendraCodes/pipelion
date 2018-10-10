import 'package:flutter/material.dart';
import 'main.dart';
import 'model.dart';

class MainListView extends StatefulWidget {
  MainListView(List<String> list) {
    mainList = list;
  }

  List<String> mainList;

  void setCurrentPage(Page page) {
    myState._setCurrentPage(page);
  }
  
  void updateList(String json) {

  }

  _MainListViewState myState;

  @override
  State<StatefulWidget> createState() {
    myState = new _MainListViewState(mainList);
    return myState;
  }
}

class _MainListViewState extends State<MainListView> {

  _MainListViewState(List<String> list) {
    currentPage = Page.posts;
    mainList = list;
  }

  void _setCurrentPage(Page page) {
    setState(() {
      currentPage = page;
    });
  }

    void _setList(List<String> list) {
      setState(() {
        mainList = list;
      });
  }

  Page currentPage;
  List<String> mainList;

  @override
  Widget build(BuildContext context) {
    if (currentPage == Page.posts) {
      return new Expanded(
        child: new ListView.builder(
          padding: new EdgeInsets.all(8.0),
          itemCount: mainList.length,
          itemBuilder: (BuildContext context, int index) {
            return new Text(mainList[index]);
          },
        )
      );
    } else if (currentPage == Page.assets) {
      
    } else if (currentPage == Page.notifications) {
      
    }
  }

}

import 'package:flutter/material.dart';
import 'main.dart';
import 'model.dart';

class MainListView extends StatefulWidget {
  MainListView(List<CardModel> list) {
    myState._setList(list);
  }

  void setCurrentPage(Page page) {
    myState._setCurrentPage(page);
  }
  
  void updateList(String json) {

  }

  _MainListViewState myState;

  @override
  State<StatefulWidget> createState() {
    myState = new _MainListViewState();
    return myState;
  }
}

class _MainListViewState extends State<MainListView> {

  _MainListViewState() {
    currentPage = Page.posts;
  }

  void _setCurrentPage(Page page) {
    setState(() {
      currentPage = page;
    });
  }

    void _setList(List<CardModel> list) {
      setState(() {
        cardModel = list;
      });
  }

  Page currentPage;
  List<CardModel> cardModel;

  @override
  Widget build(BuildContext context) {
    if (currentPage == Page.posts) {
    } else if (currentPage == Page.assets) {

    } else if (currentPage == Page.notifications) {

    }
  }

}

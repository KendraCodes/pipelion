import 'package:flutter/material.dart';
import 'main.dart';
import 'model.dart';
import 'cards.dart';

class MainListView extends StatefulWidget {
  MainListView(List<NotificationData> list) {
    mainList = list;
  }

  List<NotificationData> mainList;

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

  _MainListViewState(List<NotificationData> list) {
    currentPage = Page.posts;
  }

  void _setCurrentPage(Page page) {
    setState(() {
      currentPage = page;
      
    });
  }

  Page currentPage;
  @override
  Widget build(BuildContext context) {
    if (currentPage == Page.posts) {
      return new Expanded(
        child: new ListView.builder(
          itemCount: viewModel.posts.length,
          itemBuilder: (BuildContext context, int index) {
            return new PostCard(viewModel.posts[index]);
          },
        )
      );
    } else if (currentPage == Page.assets) {
      return new Expanded(
        child: new ListView.builder(
          itemCount: viewModel.assets.length,
          itemBuilder: (BuildContext context, int index) {
            return new AssetCard(viewModel.assets[index]);
          },
        )
      );

    } else if (currentPage == Page.notifications) {
      return new Expanded(
        child: new ListView.builder(
          itemCount: viewModel.notifications.length,
          itemBuilder: (BuildContext context, int index) {
            return new NotificationCard(viewModel.notifications[index]);
          },
        )
      );
    }
  }

}

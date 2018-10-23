import 'package:flutter/material.dart';
import 'main.dart';

class AppBarSearch extends StatefulWidget {
  AppBarSearch(void Function(String searchText) updateSearch, void Function() onSearchPressed) {
    _parentUpdateSearchText = updateSearch;
    _parentOnSearchPressed = onSearchPressed;
  }

  void Function(String searchText) _parentUpdateSearchText;
  void Function() _parentOnSearchPressed;

  void setCurrentPage(Page page) {
    myState._setCurrentPage(page);
  }

  void setSearchState(SearchState searchState) {
    myState._setSearchState(searchState);
  }

  AppBarSearchState myState;

  @override
  State<StatefulWidget> createState() {
    myState = new AppBarSearchState(_parentUpdateSearchText, _parentOnSearchPressed);
    return myState;
  }
}

class AppBarSearchState extends State<AppBarSearch> {

  AppBarSearchState(void Function(String searchText) parentUpdateSearchText, void Function() parentOnSearchPressed) {
    currentPage = Page.posts;
    _parentUpdateSearchText = parentUpdateSearchText;
    _parentOnSearchPressed = parentOnSearchPressed;
  }

  void Function(String searchText) _parentUpdateSearchText;
  void Function() _parentOnSearchPressed;

  void _updateSearchText() {
    setState(() {
      _parentUpdateSearchText(searchText);
    });
  }

  void _setCurrentPage(Page page) {
    setState(() {
      currentPage = page;
    });
  }

  void _setSearchState(SearchState searchState) {
    setState(() {
      this.searchState = searchState;
    });
  }

  Page currentPage;
  String searchText = "";
  SearchState searchState = SearchState.idle;

  void _onSearch() {}

  Text getAppBarTitle() {
    String title = "";
    switch(currentPage) {
      case Page.assets:
      title = "Assets";
      break;
      case Page.notifications:
      title = "Notifications";
      break;
      case Page.posts:
      title = "Posts";
      break;
    }
    return Text(title);
  }

  TextField getSearchBox() {
    return TextField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search here',
        hintStyle: TextStyle(color:Colors.white),
        labelStyle: TextStyle(color:Colors.white)
      ),
      onSubmitted: (newSearchText) {
        searchText = newSearchText;
        _updateSearchText();
      },
  );
  }

  @override
  Widget build(BuildContext context) {
    switch(searchState) {
    case SearchState.idle: return getAppBarTitle();
    break;
    case SearchState.searching: return getSearchBox();
    break;
    }
  }

}

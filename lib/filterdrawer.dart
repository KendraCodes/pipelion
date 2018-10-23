import 'package:flutter/material.dart';
import 'main.dart';


class FilterDrawer extends StatefulWidget {
  FilterDrawer(void Function(List<Filter> filters) updateFilters, List<Filter> Function() getFilters) {
    _parentUpdateFilters = updateFilters;
    _parentGetFilters = getFilters;
  }

  void Function(List<Filter> filters) _parentUpdateFilters;
  List<Filter> Function() _parentGetFilters;

  void setCurrentPage(Page page) {
    myState._setCurrentPage(page);
  }

  FilterDrawerState myState;

  @override
  State<StatefulWidget> createState() {
    myState = new FilterDrawerState(_parentUpdateFilters, _parentGetFilters);
    return myState;
  }
}

class FilterDrawerState extends State<FilterDrawer> {

  FilterDrawerState(void Function(List<Filter> filters) updateFilters, List<Filter> Function() getFilters) {
    _currentPage = Page.posts;
    _parentUpdateFilters = updateFilters;
    _parentGetFilters = getFilters;
    _filters = _parentGetFilters();
  }

  void Function(List<Filter> filters) _parentUpdateFilters;
  List<Filter> Function() _parentGetFilters;

  void _setCurrentPage(Page page) {
    setState(() {
      _currentPage = page;
    });
  }

  Page _currentPage;
  List<Filter> _filters;

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
          itemCount: _filters.length,
          itemBuilder: (BuildContext context, int index) {
            return new InkWell(

              onTap: () {
              _filters[index].filtered = !_filters[index].filtered;
              _parentUpdateFilters(_filters);
              Navigator.pop(context);
              },

              child:ListTile(leading: Checkbox(
                  onChanged: (changedTo) {
                    _filters[index].filtered = changedTo;
                    _parentUpdateFilters(_filters);
                    Navigator.pop(context);
                  },
                  value: _filters[index].filtered,),
                  title:Text(_filters[index].name)
                )
              );
    });
  }

}

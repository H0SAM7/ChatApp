// import 'package:flutter/material.dart';

// class SearchBar extends StatefulWidget {

//   String query ;
//   final List<String> data;
//   SearchBar({required this.data,required this.query});
//   @override
//   _SearchBarState createState() => _SearchBarState();
// }

// class _SearchBarState extends State<SearchBar> {
//  List<String> searchResults = [];

//   void onQueryChanged(String query,List<String> data) {
//     setState(() {
//       searchResults = data
//           .where((item) => item.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   // void onQueryChanged(String newQuery) {
//   //   setState(() {
//   //     query = newQuery;
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: TextField(
//         onChanged: onQueryChanged ,
//         decoration: InputDecoration(
//           labelText: 'Search',
//           border: OutlineInputBorder(),
//           prefixIcon: Icon(Icons.search),
//         ),
//       ),
//     );
//   }
// }
//   List<String> data = [
//     'Apple',
//     'Banana',
//     'Cherry',
//     'Date',
//     'Elderberry',
//     'Fig',
//     'Grapes',
//     'Honeydew',
//     'Kiwi',
//     'Lemon',
//   ];

// import 'package:flutter/material.dart';

// class SearchWidget extends StatefulWidget {
//   static String id='SearchWidget';
//   String? query;
//   final List<dynamic>?data;
//   SearchWidget({ this.data,  this.query});

//   @override
//   _SearchWidgetState createState() => _SearchWidgetState();
// }

// class _SearchWidgetState extends State<SearchWidget> {

//   List<dynamic> searchResults = [];

//   void onQueryChanged(String query) {
//     setState(() {
//       searchResults = widget.data!
//           .where((item) => item.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(16),
//           child: TextField(
//             onChanged: onQueryChanged,
//             decoration: InputDecoration(
//               labelText: 'Search',
//               border: OutlineInputBorder(),
//               prefixIcon: Icon(Icons.search),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';

class SearchAppBarDemo extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final Function(String)? onSearch;
  static String id='SearchAppBarDemo';

  SearchAppBarDemo({ this.title, this.onSearch, Key? key}) : super(key: key);

  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBarDemo> {
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _isSearching
          ? TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
              onSubmitted: (query) {
                if (widget.onSearch != null) {
                  widget.onSearch!(query);
                }
              },
            )
          : Text(widget.title!),
      actions: [
        _isSearching
            ? IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _isSearching = false;
                    _searchController.clear();
                  });
                },
              )
            : IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    _isSearching = true;
                  });
                },
              ),
      ],
    );
  }
}
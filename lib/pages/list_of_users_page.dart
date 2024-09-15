import 'package:chat_app/main.dart';
import 'package:chat_app/model/chat_model.dart';
import 'package:chat_app/model/message_model.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/widget/custom_contact.dart';
import 'package:chat_app/widget/custom_indecator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListOfUsers extends StatefulWidget {
  ListOfUsers({super.key});
  static String id = 'ListOfUsers';


  @override
  State<ListOfUsers> createState() => _ListOfUsersState();
}

class _ListOfUsersState extends State<ListOfUsers> {
  final firestore = FirebaseFirestore.instance;
  int _selectedIndex = 0;

  Stream<QuerySnapshot> fetchUserEmailsStream() {
    return firestore.collection('users').snapshots();
  }

  bool _isSearching = false;
  String? searchQuery;
  bool isLoading = false;

  // Loading indicator control
  // ChatProcessor processor = ChatProcessor();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  bool isLightMode = true;
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var emaillogin = args['email'];
    var username = args['username'];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: isLightMode ? Colors.blueAccent : Colors.black,
          title: Text(
            'Chats',
            style: TextStyle(fontSize: 26),
          ),
          actions: [
            IconButton(
              icon: Icon(isLightMode ? Icons.dark_mode : Icons.light_mode),
              onPressed: () {
                setState(() {
                  isLightMode = !isLightMode;
           
                });
                MyApp.of(context).changeTheme(
                    isLightMode ? ThemeMode.light : ThemeMode.dark);
              },
            ),
          ],
        ),
      ),
      backgroundColor: isLightMode ? Colors.blueAccent : Colors.black,
      body: _selectedIndex == 0
          ? StreamBuilder<QuerySnapshot>(
              stream: fetchUserEmailsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CustomLoadingIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No user emails found'));
                } else {
                  var docs = snapshot.data!.docs;
                  // Filter out the user with email matching emaillogin
                  var filteredDocs =
                      docs.where((doc) => doc['email'] != emaillogin).toList();

                  List<DocumentSnapshot> displayedUsers =
                      _isSearching && searchQuery != null
                          ? filteredDocs
                              .where((doc) => doc['username']
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchQuery!.toLowerCase()))
                              .toList()
                          : filteredDocs;

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: isLightMode ? Colors.white : Colors.black,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 16, left: 16, right: 16),
                          child: TextField(
                           autofocus: true,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              border: InputBorder.none,
                              suffixIcon: _isSearching
                                  ? IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          _isSearching = false;
                                          searchQuery = null;
                                        });
                                      },
                                    )
                                  : IconButton(
                                      icon: Icon(
                                        Icons.search,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isSearching = true;
                                        });
                                      },
                                    ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value.trim();
                                _isSearching = true;
                              });
                              _searchUsers(value.trim()); // Initiate search
                            },
                            // Ensure the text in TextField is controlled
                            // by the searchQuery state
                            controller:
                                TextEditingController(text: searchQuery),
                          ),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: isLoading
                              ? Center(child: CustomLoadingIndicator())
                              // : ListView.builder(
                              //     itemCount: displayedUsers.length,
                              //     itemBuilder: (context, index) {
                              //       var userDoc = displayedUsers[index];
                              //       // processor.processAndGetFirstMessages(
                              //       //     ChatPage.firstMessagesList);
                              //       Message? firstMessage =
                              //           processor.getFirstMessageForPair(
                              //               emaillogin, userDoc['email']);

                              //       return CustomContact(
                              //         username: userDoc['username'],
                              //         sender: emaillogin,
                              //         reciever: userDoc['email'],
                              //         lastMessage: firstMessage?.message,
                              //         time: firstMessage?.time,
                              //         darkmode: !isLightMode,
                              //       );
                              //     },
                              //   ),
                        :Container()),
                      ],
                    ),
                  );
                }
              },
            )
          : Scaffold(),
      // Remove or comment out the BottomNavigationBar
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.blueAccent,
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.black,
      //   selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      //   unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      //   type: BottomNavigationBarType.fixed,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.message),
      //       label: "Chats",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_box),
      //       label: "Profile",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: "settings",
      //     ),
      //   ],
      //   onTap: _onItemTapped,
      // ),
    );
  }

  void _searchUsers(String query) {
    // Set loading indicator to true when searching starts
    setState(() {
      isLoading = true;
    });

    // Simulate a delay to show loading indicator
    Future.delayed(Duration(microseconds: 0), () {
      // Perform actual search or filter operation here
      setState(() {
        isLoading =
            false; // Set loading indicator to false when search is complete
      });
    });
  }

  CustomContact search(String q) {
    return CustomContact(
      username: q,
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: []),
    );
  }
}

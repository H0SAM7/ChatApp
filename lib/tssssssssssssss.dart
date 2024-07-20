import 'package:chat_app/model/chat_model.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/model/message_model.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/widget/custom_contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListOfUsers extends StatefulWidget {
  ListOfUsers({super.key});
  static String id = 'ListOfUsers';

  @override
  State<ListOfUsers> createState() => _ListOfUsersState();
}

class _ListOfUsersState extends State<ListOfUsers> {
  final firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> fetchUserEmailsStream() {
    return firestore.collection('users').snapshots();
  }

  bool _isSearching = false;
  String? searchQuery;
  Stream? streamQuery;
  ChatProcessor processor = ChatProcessor();
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var emaillogin = args['email'];

    var username = args['username'];
    return StreamBuilder<QuerySnapshot>(
      stream: fetchUserEmailsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No user emails found'));
        } else {
          var docs = snapshot.data!.docs;
          // Filter out the user with email matching emaillogin
          var filteredDocs =
              docs.where((doc) => doc['email'] != emaillogin).toList();

          return DefaultTabController(
            initialIndex: 1,
            length: 3,
            child: Scaffold(
              backgroundColor: const Color.fromARGB(255, 209, 204, 204), 
              appBar: AppBar(
                bottom: TabBar(tabs: [
                  Tab(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white10,
                      ),
                      text: 'Settings'),
                  Tab(
                      icon: Icon(
                        Icons.call,
                        color: Colors.white10,
                      ),
                      text: 'calls'),
                  Tab(
                      icon: Icon(
                        Icons.people,
                        color: Colors.white10,
                      ),
                      text: 'Contacts'),
                ]),
                automaticallyImplyLeading: true,

                // actions: [
                //   IconButton(
                //       onPressed: () {

                //         // SearchAppBarDemo();

                //         //  Navigator.pushNamed(context, SearchAppBarDemo.id);
                //       },
                //       icon: Icon(
                //         Icons.search,
                //         color: Colors.amber,
                //       )),
                // ],
                title: _isSearching
                    ? TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          {
                            for (int i = 0; i < filteredDocs.length; i++) {
                              var x = filteredDocs[i];
                              {
                                if (x['username']==value) 
                                {
                                  search(value);
                              }
                            }
                          }
                        }
                        }
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/scholar.png',
                            height: 40,
                          ),
                          Text(
                            'Chat',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                backgroundColor: kPrimaryColor,
                centerTitle: true,
                actions: [
                  _isSearching
                      ? IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              _isSearching = false;
                            });
                          },
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.amber,
                          ),
                          onPressed: () {
                            setState(() {
                              _isSearching = true;
                            });
                          },
                        ),
                ],
              ),
              body: TabBarView(children: [
                Center(
                  child: Text('setting here'),
                ),
                Column(
                  children: [
                    //SearchWidget(query: 'hosam',data: filteredDocs as List,),
                    SizedBox(height: 20),

                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length - 1,
                        itemBuilder: (context, index) {
                          // var userDoc = snapshot.data!.docs[index];
                          var userDoc = filteredDocs[index];
                          // var i=ChatPage.firstMessagesList.length;
                          // ChatProcessor().processAndGetFirstMessages(ChatPage.firstMessagesList);
                          //var test2=ChatProcessor().getFirstMessage(emaillogin,userDoc['email'] );
                          processor.processAndGetFirstMessages(
                              ChatPage.firstMessagesList);
                          Message? firstMessage =
                              processor.getFirstMessageForPair(
                                  emaillogin, userDoc['email']);

                          return CustomContact(
                            username: userDoc['username'],
                            sender: emaillogin,
                            reciever: userDoc['email'],
                            lastMessage: firstMessage?.message,
                            time: firstMessage?.time,
                            // lastMessage:ChatPage.firstMessagesList.isEmpty?''
                            // :index<i?
                            //   ChatPage.firstMessagesList[index].message.toString()
                            // :''
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Text("calls here"),
                ),
              ]),
            ),
          );
        }
      },
    );
  }
  CustomContact search(String q){

    return CustomContact(username: q,);
    
  }
  void ReadMessage() {}
  List<dynamic> searchResults = [];

  void onQueryChanged(String query, List<dynamic> data) {
    setState(() {
      searchResults = data.where((item) => item.contains(query)).toList();
    });
  }
}

// class MyAccount extends StatelessWidget {
//    MyAccount({super.key});

// static String id='MyAccount';
//   @override
//   Widget build(BuildContext context) {


//     return Scaffold(
//       backgroundColor: Colors.amber,
//       body: CustomButton(buttonName: 'Your E-mail: ${Widget.emaillogin}'),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class menuSide extends StatelessWidget {
  Future<void> _launchLinkedInProfile() async {
    const url = 'https://www.linkedin.com/in/hosam-adel-65a450284';
    final Uri uri = Uri.parse(url);
    if (!await canLaunchUrl(uri)) {
      final bool launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched) {
        print('Could not launch $url');
      }
    } else {
      print('Cannot launch URL: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.only(top: 50),
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.facebook),
            title: Text('Profile'),
            onTap: _launchLinkedInProfile,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Account Settings'),
            onTap: () =>      Navigator.of(context).pop(),
            
          ),
               ListTile(
            leading: Icon(Icons.logout),
            title: Text('log out'),
            onTap: () => Navigator.of(context)..pop()..pop()


            
            
          ),
          
        ],
      ),
    );
  }
 }

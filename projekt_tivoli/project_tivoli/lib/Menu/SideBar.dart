import 'package:flutter/material.dart';
import 'GMap.dart';
import 'ONas.dart';
import 'Settings.dart';
import 'Kviz/StartPage.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 225.0,
            child: DrawerHeader(
                child: Image(image: AssetImage("assets/menu_ass/logo.png"), height: 120, width: 120,),
            ),
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Zemljevid z drevesi'),
            onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GMap()),
          ),
          ),
          ListTile(
            leading: Icon(Icons.ballot),
            title: Text('Kviz'),
            onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => KvizStartPage())),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Nastavitve'),
            onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Settings())),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('O Nas'),
            onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ONas())),
          ),
        ],
      ),
    );
  }
}
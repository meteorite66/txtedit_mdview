import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';


class TextEditer extends StatefulWidget {
  @override
  _TextEditerState createState() => _TextEditerState();
}

class _TextEditerState extends State<TextEditer> {
  bool isMdView = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(actions: <Widget>[
          FlatButton(
            child: Text("Plane Text"),
            onPressed:isMdView? ()=>setState(()=>isMdView=false):null,
          ),
          FlatButton(
            child: Text("MD view"),
            onPressed: isMdView? null : ()=> setState(()=>isMdView=true) ,
          ),
        ]),
        drawer: Drawer(
          child: drawerList(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:Column(
            children: <Widget>[
              //TODO MDview


            ],

          ),

        ),
      ),
    );
  }

  Widget drawerList() {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(
          height: 100.0,
          child: DrawerHeader(
            //margin:EdgeInsets.only(bottom: 0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text("TextEditer_MDview")),
          ),
        ),
        ListTile(
          title: Text("Open new file"),
          onTap: null,
        ),
        ListTile(
          title: Text("export file"),
          onTap: null,
        ),
      ],
    );
  }
}

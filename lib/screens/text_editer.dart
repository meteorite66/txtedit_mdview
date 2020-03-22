import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:path_provider/path_provider.dart';

import 'package:intl/date_symbol_data_local.dart';


import 'dart:core';
import 'dart:io';


import 'dart:async';

class TextEditer extends StatefulWidget {
  @override
  _TextEditerState createState() => _TextEditerState();
}

class _TextEditerState extends State<TextEditer> {
  bool isMdView = false;
  String text = "";
  TextEditingController _textEditingController;

  File file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = new TextEditingController(text: '');
    _textEditingController.text = text;

    //TODO よみこみ
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(actions: <Widget>[
          FlatButton(
            child: isMdView ? Opacity(opacity: 0.4,
                child: Text("Text edit",
                  style: TextStyle(decoration: TextDecoration.none),)) : Text(
              "Text edit",
              style: TextStyle(decoration: TextDecoration.underline),),
            onPressed: isMdView ? () => setState(() => isMdView = false) : () =>
                Center(),
          ),
          FlatButton(
            child: isMdView
                ? Text("MD view",
              style: TextStyle(decoration: TextDecoration.underline),)
                : Opacity(opacity: 0.4,
                child: Text("MD view",
                  style: TextStyle(decoration: TextDecoration.none),)),
            onPressed: isMdView ? () => Center() : () =>
                setState(() => isMdView = true),
          ),
        ]),
        drawer: Drawer(
          child: drawerList(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              //TODO MDview
              isMdView
                  ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: MarkdownBody(data: text),
                  ))
                  : Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _textEditingController,
                    maxLines: null,
                    onChanged: (value) => setState(() => text = value),
                  ),
                ),
              )
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
          title: Text("Open previous file"),
          onTap: () => getTextFile(),
        ),
        ListTile(
          title: Text("export file"),
          onTap: ()async=> exportTextFile(),
        ),
      ],
    );
  }

  Future<Widget> getTextFile() async {

    final _readFilePath = await getApplicationDocumentsDirectory();

    File(_readFilePath.path+'/previous.md').readAsString().then((String contents) {
      _textEditingController.text = contents;
      print (_textEditingController.text);

    });


    setState(() {
    });
  }
//    final savePath = await getApplicationDocumentsDirectory();


  exportTextFile() async {
    final savePath = await getApplicationDocumentsDirectory();
    print(savePath);

    initializeDateFormatting("ja-JP", null);
    final loadedTime = new DateTime.now();
    //final String fileName = DateFormat('yyyy-MM-dd-hh-mm', Intl.defaultLocale).format(loadedTime) +".md";
    String fileName = "previous.md";
    File saveFile = File(savePath.path + '/' + fileName);

    await showDialog<int>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("$fileName"),
            content: Text("保存しますか？"),
            actions: <Widget>[
              // ボタン領域
              FlatButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: Text("OK"),
                onPressed: () =>
                    {
                  saveFile.writeAsString(_textEditingController.text),
                  Navigator.pop(context),
                },
              ),
            ],
          );
        }
    );


  }

  }





import 'package:flutter/material.dart';
import 'screens/text_editer.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "textedit_mdview",
      home: TextEditer(),
    );
  }
}

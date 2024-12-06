// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:widget_attribute_explainer/widget_view.dart';

import 'config/themes.dart';

void main() {
  runApp(const WidgetExplain());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: learnWidget,
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}

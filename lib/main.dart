import 'package:flutter/material.dart';
import 'CCList.dart';

void main() => runApp(CCTracker());


class CCTracker extends StatelessWidget {
  const CCTracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitcoin-pulsar',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: CCList(),
    );
  }
}

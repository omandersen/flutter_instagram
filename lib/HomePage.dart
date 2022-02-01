import 'package:flutter/material.dart';
import 'package:instagram_flutter/resources/Colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hjemmeside'),
        backgroundColor: fishedBlue,
      ),
      body: Center(
        child: Container(
          height: 80,
          width: 150,
          decoration: BoxDecoration(
              color: fishedBlue, borderRadius: BorderRadius.circular(10)),
          child: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Velkommen til Fished',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}
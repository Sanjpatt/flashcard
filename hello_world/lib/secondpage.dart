import 'package:flutter/material.dart';


class SecondPage extends StatelessWidget {
  final String detail;
  SecondPage(this.detail);
  
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Flashcard Detail'),
        ),
        body: Card(
          child: Container (
            height: 250.0,
            child : Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(detail)
            )
          )
        )
      );
    }
}

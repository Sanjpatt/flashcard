import 'package:flutter/material.dart';
import 'dart:convert';
import './secondpage.dart';
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flashcards'),
        ),
        drawer: AppDrawer(),
        body: Center(
          child: Text('Collection of FlashCards'),
        ),
      ),
    );
  }
}

class FlashCards extends StatefulWidget {
  @override
  createState() => FlashCardsState();
}

class FlashCardsState extends State<FlashCards> {
  List _flashcards = new List();
  //final _apigatewayurl =
  //    "https://gfioehu47k.execute-api.us-west-1.amazonaws.com/staging/main";
  final _apigatewayurl = "https://api.github.com/users";
  TextEditingController controller = new TextEditingController();
  String filter;

  @override
  void initState() {
    super.initState();
    /*http
        .get(_apigatewayurl)
        .then((response) => response.body)
        .then(json.decode)
        .then((flashcards) {
      flashcards.forEach(_addFlashcard);
    });*/
    getData().then((res) {
      setState(() {
        _flashcards.addAll(res);
      });
    });

    /*controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });*/
    /*http.get(_apigatewayurl).then((http.Response response) {
      print(json.decode(response.body));
      final List<Flashcard> fetchedFlashCards = [];
      final List<Map<String, dynamic>> flashcardListData =
          json.decode(response.body);
      flashcardListData.forEach((Map<String, dynamic>flashCardData) {
        final Flashcard fc = Flashcard(
            title: flashCardData["title"], overview: flashCardData["overview"]);
        fetchedFlashCards.add(fc);
      });
        _flashcards = fetchedFlashCards;

    });*/
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Build');
    return Scaffold(
        appBar: AppBar(
          title: Text('Flashcards'),
        ),
        body: 
        Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          new TextField(
            decoration: InputDecoration(labelText: "Search"),
            controller: controller,
          ),
          new Expanded(
              child: ListView.builder(
                  itemBuilder: (BuildContext context, int position) {
                    return
                      _getRowWithBoxDecoration(_flashcards[position]['login'],
                          _flashcards[position]['url'], context);
                          },
                  itemCount: _flashcards.length))
        ]));
  }
  /*void _addFlashcard(dynamic flashcard) {
    _flashcards.add(new Flashcard(
        title: flashcard["title"], overview: flashcard["overview"]));
  }*/

  Widget _getRowWithBoxDecoration(
      String title, String detail, BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black12))),
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: new ListTile(
              leading: const Icon(Icons.add_circle),
              title: Text(title),
              onTap: () {
                print('this is the detail');
                print(detail);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage(detail)),
                );
              },
            )));
  }

  Future<List> getData() async {
    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.parse(_apigatewayurl));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var jsonString = await response.transform(utf8.decoder).join();
      return json.decode(jsonString);
    } else {
      return new List();
    }
  }
}

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        ListTile(
          title: Text('AP Psych'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FlashCards()),
            );
          },
        ),
      ],
    ));

  }

}


class FirebaseData extends StatelessWidget {
  const FirebaseData({Key key, this.title}) : super(key : key);

final String title;

Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
  return new ListTile(
    key: new ValueKey(document.documentID),
    title: new Container(
      decoration: new BoxDecoration(
        border: new Border.all(color: const Color(0x80000000)),
        borderRadius: new BorderRadius.circular(5.0),
      ),
      padding: const EdgeInsets.all(10.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Text(document['name']),
          ),
          new Text(
            document['votes'].toString(),
          ),
        ],
      ),
    ),
  );
}

@override
Widget build(BuildContext context) {
  return new Scaffold(
    body: StreamBuilder(
      stream: Firestore.instance.collection('flashcard').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('Loading');
        return new ListView.builder(
          itemExtent: 55.0,
          itemBuilder: (context, index) =>
          _buildListItem(context, snapshot.data.documents[index]),
        
        );
      }

    )
  );
}
}

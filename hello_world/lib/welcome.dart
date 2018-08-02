import 'package:flutter/material.dart';

import './main.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}


class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 800));
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.easeIn,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.lightGreen,
      body: new Stack(
        children: <Widget>[
          new Image(
            image: new AssetImage(
                "additions/water-drop-splash-johan-swanepoel.jpeg"),
            //fit: BoxFit.cover,
            color: Colors.black87,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new FlutterLogo(),
              new Form(
                child: new Theme(
                    data: new ThemeData(
                      brightness: Brightness.light,
                    ),
                    child: new Column(
                      children: <Widget>[
                        new TextFormField(
                          decoration: new InputDecoration(
                            hintText: "Enter Email",
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        new TextFormField(
                          decoration: new InputDecoration(
                            hintText: "Enter Password",
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        new MaterialButton(
                            color: Colors.white,
                            textColor: Colors.black,
                            child: new Text("Login"),
                            onPressed: () {
                              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },  
                            
                            ),
                              
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

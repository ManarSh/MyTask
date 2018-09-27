import 'package:flutter/material.dart';
import 'dart:ui';

void main() => runApp(new QuoteApp());

class QuoteApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Motivational Quote App',
      home: new Scaffold(body: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/images/Welcome_background.png'),
                fit: BoxFit.cover,
              ),
            ),

          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              //your elements here


              new RaisedButton(
                child: new Text('GET STARTED', style: new TextStyle (color: Colors.white, fontStyle: FontStyle.italic, fontSize: 20.0)),
                // color: Theme.of(context).accentColor,
                elevation: 4.0,
                //splashColor: Colors.white.withOpacity(0.2),
                color: Colors.lightGreen.withOpacity(0.10),
                onPressed: (){Navigator.of(context).pushNamed('/login');},
              ),
            ],
          ),
        ],
      )),
    );
  }
}
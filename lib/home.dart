import 'package:flutter/material.dart';
import './auth_provider.dart';
import 'AddChildPage.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => new _homeState();
  static String routeName = '/home';

}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {}
}

class HomePage extends StatelessWidget {
  HomePage({this.onSignedOut});
  final VoidCallback onSignedOut;

  void _signOut(BuildContext context) async {
    try {
      var auth = AuthProvider.of(context).auth;
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Parent Home page'),
          actions: <Widget>[
            FlatButton(
                child: Text('Logout',
                    style: TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: () => _signOut(context))
          ],
        ),
        body: new Container(
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new IconButton(
                    icon: new Icon(Icons.add_circle_outline, color: Colors.green,),
                    iconSize: 70.0,
                    onPressed: (){Navigator.of(context).pushNamed('/AddChildPage');}
                ),
                new Text ('Add child',style: TextStyle(fontSize: 23.0, color: Colors.green))
              ],
            )
                ),

        ));
  }
}
/*import 'dart:async';

import 'package:flutter/material.dart';
import './database.dart';
import './home.dart';

class AddChildPage extends StatefulWidget {
  static String routeName = '/AddChildPage';

  final String childKey;

  AddChildPage({Key key, this.childKey}) : super(key: key);

  @override
  _AddChildPageState createState() => new _AddChildPageState();
}

class _AddChildPageState extends State<AddChildPage> {
  final _nameFieldTextController = new TextEditingController();

  StreamSubscription _subscriptionName;

  @override
  void initState() {
    _nameFieldTextController.clear();

    Database.getNameStream(widget.childKey, _updateName)
        .then((StreamSubscription s) => _subscriptionName = s);

    super.initState();
  }

  @override
  void dispose() {
    if (_subscriptionName != null) {
      _subscriptionName.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add Child's Info"),
      ),
      body: new ListView(
        children: <Widget>[
        //  new ListTile(

            new TextField(
              //controller: _nameFieldTextController,
              decoration: new InputDecoration(
                  icon: new Icon(Icons.edit),
                  labelText: "Child Name",
                  hintText: "Enter the child name..."
              ),
              onChanged: (String value) {
                Database.saveName(widget.childKey, value);
              },
            ),
            new TextField(
             // controller: _nameFieldTextController,
              decoration: new InputDecoration(
                  icon: new Icon(Icons.date_range),
                  labelText: "Child Age",
                  hintText: "Enter the child Age..."
              ),
              onChanged: (String value) {
                Database.saveName(widget.childKey, value);
              },
            ),
            new TextField(
              //controller: _nameFieldTextController,
              decoration: new InputDecoration(
                  icon: new Icon(Icons.child_care),
                  labelText: "Child gender",
                  hintText: "Enter the child gender..."
              ),
              onChanged: (String value) {
                Database.saveName(widget.childKey, value);
              },
            ),
            new TextField(
              //controller: _nameFieldTextController,
              decoration: new InputDecoration(
                  icon: new Icon(Icons.email),
                  labelText: "Child email",
                  hintText: "Enter the child email..."
              ),
              onChanged: (String value) {
                Database.saveName(widget.childKey, value);
              },
            ),
            new TextField(
             // controller: _nameFieldTextController,
              decoration: new InputDecoration(
                  icon: new Icon(Icons.lock),
                  labelText: "Child password",
                  hintText: "Enter the child password..."
              ),
              onChanged: (String value) {
                Database.saveName(widget.childKey, value);
              },
            ),
         // )
            new IconButton(
                icon: new Icon(Icons.add_circle_outline, color: Colors.green,),
                iconSize: 70.0,
                onPressed: (){
                 // Navigator.of(context).pushNamed('/home');
                }
            ),
            //new Text ('Add child',style: TextStyle(fontSize: 23.0, color: Colors.green))
        ],
      ),
    );
  }

  void _updateName(String name) {
    _nameFieldTextController.value = _nameFieldTextController.value.copyWith(
      text: name,
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path/path.dart'; //needed for basename
import 'dart:async';
import 'dart:io';
import './storage.dart';


class AddChildPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _AddChildPageState();
  }
}

void main() async {
  final FirebaseApp app = await FirebaseApp.configure(
      name: 'firebaseapp',
      options: new FirebaseOptions(
        googleAppID: '1:705387952593:android:7bd71543f89d056a',
        gcmSenderID: '705387952593',
        apiKey: 'AIzaSyDbVZxUoli9QszN47IsV2RgH-Fb6Krp3KE',
        projectID: 'mytasktest-f5eb6',
        databaseURL: 'https://mytasktest-f5eb6.firebaseio.com',
      )
  );

  final FirebaseStorage storage = new FirebaseStorage(
      app: app, storageBucket: 'gs://mytasktest-f5eb6.appspot.com');
  final FirebaseDatabase database = new FirebaseDatabase(app: app);
}
@override
class _AddChildPageState extends State<AddChildPage>{

  /*final formKey = new GlobalKey<FormState>();
  String _name;
  String _userName;
  String _password;*/
  _AddChildPageState({this.storage});
  final FirebaseStorage storage;
  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;

  bool validateAndSave(){
    final form = formKey.currentState;
    if (form.validate()){
      form.save();
      return true;
      // print('Form is valid. Name: $_name, Password: $_password');
    }
    //print('Form is invalid.  Name: $_name, Password: $_password');
    return false;

  }

  void validateAndSubmit() async {
    if (validateAndSave()){
      print('Add child');
    }
    try{
      FirebaseUser child = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
      print('Add Child: ${child.uid}');
    }
    catch (e) {
      print('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context){
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Add new Child'),
        ),
        body: new Container(
            padding: EdgeInsets.all(16.0),
            child: new Form(
                key: formKey,
                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new TextFormField(
                        decoration: new InputDecoration(labelText: 'email'),
                        validator: (value) => value.isEmpty ? 'email can\'t be empty' : null,
                        onSaved: (value) => _email = value,
                      ),
                       new TextFormField(
                        decoration: new InputDecoration(labelText: 'User Name'),
                        validator: (value) => value.isEmpty ? 'User Name can\'t be empty' : null,
                       // onSaved: (value) => _userName = value,
                      ),

                      new TextFormField(
                        decoration: new InputDecoration(labelText: 'age'),
                        //validator: (value) => value.isEmpty ? 'User Name can\'t be empty' : null,
                        // onSaved: (value) => _userName = value,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
                        onSaved: (value) => _password = value,

                      ),
                      new RaisedButton(
                        child: new Text('Add', style: new TextStyle(fontSize: 20.0)),
                        onPressed: validateAndSubmit,
                      ),
                      //new FlatButton(
                      //child: new Text('Cancel', style: new TextStyle(fontSize: 20.0)),
                      //onPressed: moveToRegister,)
                    ]
                )
            )
        )
    );
  }
}
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
//import 'package:intl/intl.dart';

class Database {

  static Future<String> AddChild() async {
    String accountKey = await _getAccountKey();

    var Child = <String, dynamic>{
      'name' : '',
      'Age': '',
      'Gender': '',
      'Email':'',
      'Password':'',
       // 'created': _getDateNow(),
    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("Children")
        .push();

    reference.set(Child);

    return reference.key;
  }

  static Future<void> saveName(String childKey, String name) async {
    String accountKey = await _getAccountKey();

    return FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("Children")
        .child(childKey)
        .child('name')
        .set(name);
  }

  static Future<StreamSubscription<Event>> getNameStream(String childKey,
      void onData(String name)) async {
    String accountKey = await _getAccountKey();

    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("Children")
        .child(childKey)
        .child("name")
        .onValue
        .listen((Event event) {
      String name = event.snapshot.value as String;
      if (name == null) {
        name = "";
      }
      onData(name);
    });

    return subscription;
  }

  static Future<Query> queryChildInfo() async {
    String accountKey = await _getAccountKey();

    return FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("Children")
        .orderByChild("name");
  }
}

Future<String> _getAccountKey() async {
  return '12345678';
}
/*
/// requires: intl: ^0.15.2
String _getDateNow() {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
  return formatter.format(now);
}

*/
/*import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

/*int counter;
DatabaseReference ChildRef;
DatabaseError error;

//Create table here
void init(FirebaseDatabase database) async {
  ChildRef = FirebaseDatabase.instance.reference().child('MyTask/Child');
  ChildRef.keepSynced(true);//to keep track to changes since it's real time database
  database.setPersistenceEnabled(true);
  database.setPersistenceCacheSizeBytes(10000000);
}*/
Future<Null> addChild(String user) async {
  DatabaseReference ChildRef;
  ChildRef = FirebaseDatabase.instance.reference().child('Children/${user}');

  for(int i = 0; i < 30; i++) {
    ChildRef.update(<String,String>{'Key${i.toString()}' : 'Body ${i.toString()}'});
  }
}

Future<Null> removeTask(String user) async {
  DatabaseReference _TaskRef;
  _TaskRef = FirebaseDatabase.instance.reference().child('Task/${user}');
  await _TaskRef.remove();
}

Future<Null> addTask(String user) async {
  DatabaseReference _TaskRef;
  _TaskRef = FirebaseDatabase.instance.reference().child('Task/${user}');

  for(int i = 0; i < 30; i++) {
    _TaskRef.update(<String,String>{'Key${i.toString()}' : 'Body ${i.toString()}'});
  }
}

/*
Future<Null> setData(String user, String key, String value) async {
  DatabaseReference _messageRef;
  _messageRef = FirebaseDatabase.instance.reference().child('messages/${user}');
  _messageRef.set(<String,String>{key : value});
}
//Sprint 2
Future<Null> updateChildData(String user, String key, String value) async {
  DatabaseReference _messageRef;
  _messageRef = FirebaseDatabase.instance.reference().child('messages/${user}');
  _messageRef.update(<String,String>{key : value});
  */
}*/


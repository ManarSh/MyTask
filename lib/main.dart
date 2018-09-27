import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import './auth_provider.dart';
import './root_page.dart';
import './auth.dart';
import './AddChildPage.dart';
import './LaunchPage.dart';
import './home.dart';
import './login.dart';

void main() {
  runApp(new MyApp()); }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: 'Login',
        theme: ThemeData(
          primarySwatch: Colors.green,
          buttonColor: Colors.green,
        ),
          routes: <String, WidgetBuilder>{
            //All available pages
            '/LaunchPage': (BuildContext contrext) => new QuoteApp(),
            '/AddChildPage': (BuildContext contrext) => new AddChildPage(),
            '/home': (BuildContext contrext) => new home(),
            '/RootPage':(BuildContext context) => new RootPage(),
            '/login': (BuildContext context) => new LoginPage(),
          },
         home: QuoteApp(),
        // home: RootPage(),
      ),
    );
  }

}
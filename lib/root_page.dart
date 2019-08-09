import 'package:flutter/material.dart';
import 'login_page.dart';
import 'auth.dart';
import 'home_page.dart';

class RootPage extends StatefulWidget {
  RootPage(
      {this.auth}); //creating instance of Auth in RootPage, accessible to RootPage
  final BaseAuth auth;

  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn } //terse values, no change

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    //called before any build widgets, configures initial states of app
    super.initState();
    widget.auth.currentUser().then((userID) {
      //currentUser returns a future, .then is used to get that value in the initState
      setState(() {
        authStatus = userID == null
            ? AuthStatus.notSignedIn
            : AuthStatus.signedIn; //checks if currentUser is signed in or not.
      });
    });
  }

  void _signedIn() {
    //method for sign in
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    //method for sign out
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return LoginPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return HomePage(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
    }
  }
}

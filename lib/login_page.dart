import 'package:flutter/material.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage(
      {this.auth, this.onSignedIn}); //creating instance of Auth in LoginPage
  final BaseAuth auth;
  final VoidCallback
      onSignedIn; //method that requires and returns no parameters

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  String _firstName;
  String _lastName;
  FormType _formType = FormType.login;
  final focusLName = FocusNode();
  final focusEmail = FocusNode();
  final focus =
      FocusNode(); //focus variable for switching input fields automatically for user

  int _radioGroupValue = 0;

  bool validateAndSave() {
    //validates form validator when validateAndSubmit is called
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    //called when login button pressed
    if (validateAndSave()) {
      try {
        //connects to Firebase using credentials
        if (_formType == FormType.login) {
          String userID = await widget.auth.signInWithEmailAndPassword(
              _email, _password); //calls Auth class which implements BaseAuth
          print('Signed in: $userID');
        } else {
          String userID = await widget.auth
              .createUserWithEmailAndPassword(_email, _password);
          print('Registred user: $userID');
        }
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    setState(() {
      formKey.currentState.reset();
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false, //To avoid Bottom Overflow error
      backgroundColor: Colors.indigo.shade800,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 0.0),
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/logo_two.png',
                  width: 250.0,
                  height: 250.0,
                )),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: buildInputs() + buildSubmitButtons(),
                  )),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    if (_formType == FormType.login) {
      return [
        TextFormField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              labelText: 'Email', labelStyle: TextStyle(color: Colors.white)),
          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
          onSaved: (value) => _email = value,
          //sets value to email once validated
          onFieldSubmitted: (v) {
            FocusScope.of(context).requestFocus(focus);
          },
        ),
        TextFormField(
          focusNode: focus,
          style: TextStyle(color: Colors.white),
          obscureText: true,
          decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.white)),
          validator: (value) =>
              value.isEmpty ? 'Password can\'t be empty' : null,
          onSaved: (value) =>
              _password = value, //sets value to password once validated
        ),
      ];
    } else {
      return [
        Row(
          children: <Widget>[
            InkWell(
              onTap: () => changeRadioSelection(0),
              child: Row(
                children: <Widget>[
                  Radio(
                      value: 0,
                      groupValue: _radioGroupValue,
                      activeColor: Colors.white,
                      onChanged: (int value) {
                        changeRadioSelection(value);
                      }),
                  Text(
                    'Artisan',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            InkWell(
              onTap: () => changeRadioSelection(1),
              child: Row(
                children: <Widget>[
                  Radio(
                    value: 1,
                    groupValue: _radioGroupValue,
                    onChanged: (int value) {
                      changeRadioSelection(value);
                    },
                    activeColor: Colors.white,
                  ),
                  Text(
                    'Customer',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  )
                ],
              ),
            )
          ],
        ),
        TextFormField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              labelText: 'First Name',
              labelStyle: TextStyle(color: Colors.white)),
          validator: (value) =>
              value.isEmpty ? 'First Name cannot be empty' : null,
          onSaved: (value) => _firstName = value,
          //sets value to email once validated
          onFieldSubmitted: (v) {
            FocusScope.of(context).requestFocus(focusLName);
          },
        ),
        TextFormField(
          focusNode: focusLName,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              labelText: 'Last Name',
              labelStyle: TextStyle(color: Colors.white)),
          validator: (value) =>
              value.isEmpty ? 'Last Name cannot be empty' : null,
          onSaved: (value) => _lastName = value,
          //sets value to email once validated
          onFieldSubmitted: (v) {
            FocusScope.of(context).requestFocus(focusEmail);
          },
        ),
        TextFormField(
          focusNode: focusEmail,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              labelText: 'Email', labelStyle: TextStyle(color: Colors.white)),
          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
          onSaved: (value) => _email = value,
          //sets value to email once validated
          onFieldSubmitted: (v) {
            FocusScope.of(context).requestFocus(focus);
          },
        ),
        TextFormField(
          focusNode: focus,
          style: TextStyle(color: Colors.white),
          obscureText: true,
          decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.white)),
          validator: (value) =>
              value.isEmpty ? 'Password can\'t be empty' : null,
          onSaved: (value) =>
              _password = value, //sets value to password once validated
        ),
      ];
    }
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: RaisedButton(
            onPressed: validateAndSubmit,
            child: Text(
              'Login',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
        FlatButton(
            onPressed: moveToRegister,
            child: Text(
              'New user?',
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ))
      ];
    } else {
      return [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: RaisedButton(
            onPressed: validateAndSubmit,
            child: Text(
              'Sign up',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
        FlatButton(
            onPressed: moveToLogin,
            child: Text(
              'Have an account?',
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ))
      ];
    }
  }

  void changeRadioSelection(int value) {
    setState(() {
      _radioGroupValue = value;
      print('Radio butto selected: $value');
    });
  }
}

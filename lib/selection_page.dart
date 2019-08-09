import 'package:flutter/material.dart';

class SelectionPage extends StatelessWidget {
  void artisanSelect() {}

  void customerSelect() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade800,
      body: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/logo_two.png',
                width: 300.0,
                height: 300.0,
              )),
          Text(
            'Please select below:',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            child: Column(
              children: buildButtonSelect(),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildButtonSelect() {
    return [
      ButtonTheme(
        minWidth: 130.0,
        child: OutlineButton(
          onPressed: () {},
          child: Text(
            'Artisan',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          borderSide: BorderSide(
            width: 2.0,
            color: Colors.white,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(17.0)),
        ),
      ),
      ButtonTheme(
        minWidth: 130.0,
        child: OutlineButton(
          onPressed: () {},
          child: Text(
            'Customer',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          borderSide: BorderSide(
            width: 2.0,
            color: Colors.white,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(17.0)),
        ),
      ),
    ];
  }
}

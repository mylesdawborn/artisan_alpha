import 'package:flutter/material.dart';

//services imports
import 'package:artisan_alpha/services/auth.dart';
import 'package:artisan_alpha/services/root_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Artisan',
        home: RootPage(
          auth: Auth(),
        ));
  }
}

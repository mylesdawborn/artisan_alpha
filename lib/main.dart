import 'package:flutter/material.dart';
import 'auth.dart';
import 'root_page.dart';
import 'selection_page.dart';

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

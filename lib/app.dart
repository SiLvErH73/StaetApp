import 'package:flutter/material.dart';
import 'package:mvp/router/ruter.dart';
import 'package:mvp/theme/theme.dart';

class mvp extends StatelessWidget {
  const mvp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mvp',
      theme: darkTheme,
      routes: routes,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:listview_custom_with_rest_api/app_screen/home_page.dart';
import 'package:listview_custom_with_rest_api/app_screen/splash_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "List View Custom",
    home: SplashScreen(),
    routes: <String, WidgetBuilder> {
      '/homePage': (BuildContext context) => HomePage()
    },
  ));
}
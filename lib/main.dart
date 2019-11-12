import 'package:flutter/material.dart';
import 'package:gifs/ui/home_page.dart';

String api =
    'https://api.giphy.com/v1/gifs/trending?api_key=U4ZRGvIj2hClqhn1KQY5BemyIzEq1iTs&limit=20&rating=G';
String searchapi =
    'https://api.giphy.com/v1/gifs/search?api_key=U4ZRGvIj2hClqhn1KQY5BemyIzEq1iTs&q=dogs&limit=25&offset=&rating=G&lang=en';
void main() {
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
      hintColor: Colors.white,
    ),
  ));
}

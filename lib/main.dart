import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
        title: 'Personagens Star Wars',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StarWarsFilmesPersonagens(),
      )
  );
}

class StarWarsFilmesPersonagens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
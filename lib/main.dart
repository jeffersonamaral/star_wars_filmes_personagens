import 'package:flutter/material.dart';
import 'package:star_wars_filmes_personagens/util/route_generator.dart';
import 'package:star_wars_filmes_personagens/view/widget/home.dart';

void main() {
  runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Personagens Star Wars',
          initialRoute: RouteGenerator.home,
          onGenerateRoute: RouteGenerator.generateRoute,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Home()
      )
  );
}
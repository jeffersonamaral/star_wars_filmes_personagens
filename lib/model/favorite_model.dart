import 'package:flutter/material.dart';

abstract class FavoriteModel {

  static final int typeFilm = 0;

  static final int typePeople = 1;

  bool favorite = false;

  late String name;

  late int _type;

  int get type;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
    };
  }

}
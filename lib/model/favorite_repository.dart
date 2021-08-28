import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:star_wars_filmes_personagens/model/favorite_model.dart';

import '../util/constants.dart';
import 'film_model.dart';
import 'people_model.dart';

class FavoriteRepository {

  late Database database;

  String _tableName = 'favorite';

  bool _initialized = false;

  FavoriteRepository();

  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    database = await openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_tableName(name TEXT PRIMARY KEY, type INTEGER NOT NULL)',
        );
      },
      version: 1,
    );

    _initialized = true;
  }

  void save(FavoriteModel favoriteModel) async {
    await database.insert(_tableName, favoriteModel.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void delete(FavoriteModel favoriteModel) async {
    await database.delete(_tableName,
      where: 'name = ?',
      whereArgs: [favoriteModel.name],
    );
  }

  Future<List<FavoriteModel>> findAll() async {
    if (!_initialized) {
      await initialize();
    }

    final List<Map<String, dynamic>> maps = await database.query(_tableName);

    return List.generate(maps.length, (i) {
      if (maps[i]['type'] == FavoriteModel.typeFilm) {
        return FilmModel.fromDatabaseMap(maps[i]);
      } else {
        return PeopleModel.fromDatabaseMap(maps[i]);
      }
    });
  }

}
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../util/constants.dart';

abstract class AbstractRepository {

  @protected
  late Database database;

  @protected
  String favoriteTableName = 'favorite';

  @protected
  String avatarTableName = 'avatar';

  @protected
  String avatarConfigTableName = 'avatar_config';

  @protected
  bool initialized = false;

  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    database = await openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE $favoriteTableName(name TEXT PRIMARY KEY, type INTEGER NOT NULL)',
        );
        db.execute(
          'CREATE TABLE $avatarTableName(avatar_data TEXT)',
        );
        db.execute(
          'CREATE TABLE $avatarConfigTableName(avatar_config_data TEXT PRIMARY KEY)',
        );
      },
      version: 1,
    );

    initialized = true;
  }

}
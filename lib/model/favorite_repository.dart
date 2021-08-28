import 'package:sqflite/sqflite.dart';

import 'abstract_repository.dart';
import 'favorite_model.dart';
import 'film_model.dart';
import 'people_model.dart';

class FavoriteRepository extends AbstractRepository {

  FavoriteRepository();

  void save(FavoriteModel favoriteModel) async {
    if (!initialized) {
      await initialize();
    }

    await database.insert(favoriteTableName, favoriteModel.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void delete(FavoriteModel favoriteModel) async {
    if (!initialized) {
      await initialize();
    }

    await database.delete(favoriteTableName,
      where: 'name = ?',
      whereArgs: [favoriteModel.name],
    );
  }

  Future<List<FavoriteModel>> findAll() async {
    if (!initialized) {
      await initialize();
    }

    final List<Map<String, dynamic>> maps = await database.query(favoriteTableName);

    return List.generate(maps.length, (i) {
      if (maps[i]['type'] == FavoriteModel.typeFilm) {
        return FilmModel.fromDatabaseMap(maps[i]);
      } else {
        return PeopleModel.fromDatabaseMap(maps[i]);
      }
    });
  }

}
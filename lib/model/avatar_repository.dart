import 'package:sqflite/sqflite.dart';
import 'package:star_wars_filmes_personagens/model/avatar_model.dart';

import 'abstract_repository.dart';

class AvatarRepository extends AbstractRepository {

  AvatarRepository();

  void save(AvatarModel avatarModel) async {
    if (!initialized) {
      await initialize();
    }

    await database.delete(avatarTableName);
    await database.insert(avatarTableName, avatarModel.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<AvatarModel?> find() async {
    if (!initialized) {
      await initialize();
    }

    final List<Map<String, dynamic>> maps = await database.query(avatarTableName, limit: 1);

    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return AvatarModel.fromDatabaseMap(maps[i]);
      }).first;
    } else {
      return null;
    }

  }

}
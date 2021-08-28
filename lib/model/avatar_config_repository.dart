import 'package:sqflite/sqflite.dart';

import 'abstract_repository.dart';
import 'avatar_config_model.dart';

class AvatarConfigRepository extends AbstractRepository {

  void save(AvatarConfigModel avatarConfigModel) async {
    if (!initialized) {
      await initialize();
    }

    await database.delete(avatarConfigTableName);
    await database.insert(avatarConfigTableName, avatarConfigModel.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<AvatarConfigModel?> find() async {
    if (!initialized) {
      await initialize();
    }

    final List<Map<String, dynamic>> maps = await database.query(avatarConfigTableName, limit: 1);

    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return AvatarConfigModel.fromDatabaseMap(maps[i]);
      }).first;
    } else {
      return null;
    }

  }

}
import 'package:star_wars_filmes_personagens/model/abstract_entity.dart';

class Film extends AbstractEntity {

  late int _episode_id;

  late String _title;

  Film.fromMap(Map<String, dynamic> map) {
    _episode_id = map['episode_id'];
    _title = map['title'];
  }

  @override
  String get label => _title;

  @override
  Type get type => Type.people;

}
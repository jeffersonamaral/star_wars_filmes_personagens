import 'package:star_wars_filmes_personagens/model/abstract_entity.dart';

class People extends AbstractEntity {

  late String _name;

  People.fromMap(Map<String, dynamic> map) {
    _name = map['name'];
  }

  @override
  String get label => _name;

  @override
  Type get type => Type.people;

}
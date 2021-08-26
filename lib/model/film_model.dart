import 'abstract_model.dart';

class FilmModel extends AbstractModel {

  late int _episode_id;

  late String _title;

  FilmModel.fromMap(Map<String, dynamic> map) {
    _episode_id = map['episode_id'];
    _title = map['title'];
  }

  @override
  String get label => _title;

  @override
  Type get type => Type.people;

}
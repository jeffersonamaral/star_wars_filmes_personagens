import 'abstract_model.dart';

class PeopleModel extends AbstractModel {

  late String _name;

  PeopleModel.fromMap(Map<String, dynamic> map) {
    _name = map['name'];
  }

  @override
  String get label => _name;

  @override
  Type get type => Type.people;

}
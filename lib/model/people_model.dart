import 'favorite_model.dart';

class PeopleModel extends FavoriteModel {

  PeopleModel.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
  }

  PeopleModel.fromDatabaseMap(Map<String, dynamic> map) {
    this.name = map['name'];
  }

  @override
  int get type => FavoriteModel.typePeople;

}
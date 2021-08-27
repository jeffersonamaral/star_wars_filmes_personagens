import 'favorite_model.dart';

class FilmModel extends FavoriteModel {

  FilmModel.fromMap(Map<String, dynamic> map) {
    this.name = map['title'];
  }

  FilmModel.fromDatabaseMap(Map<String, dynamic> map) {
    this.name = map['name'];
  }

  @override
  int get type => FavoriteModel.typeFilm;

}
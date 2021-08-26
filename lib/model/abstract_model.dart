abstract class AbstractModel {

  bool _favorite = false;

  bool get favorite => _favorite;

  String get label;

  Type get type;
}

enum Type {
  film,
  people
}
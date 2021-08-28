import '../model/avatar_model.dart';
import '../model/avatar_repository.dart';

class AvatarController {

  late AvatarRepository _repository;

  AvatarController(this._repository);

  void save(AvatarModel avatarModel) async {
    _repository.save(avatarModel);
  }

  Future<AvatarModel?> load() {
    return _repository.find();
  }

}
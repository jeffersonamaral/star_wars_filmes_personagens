import '../model/avatar_config_model.dart';
import '../model/avatar_config_repository.dart';

class AvatarConfigController {

  late AvatarConfigRepository _repository;

  AvatarConfigController(this._repository);

  void save(AvatarConfigModel avatarConfigModel) async {
    _repository.save(avatarConfigModel);
  }

  Future<AvatarConfigModel?> load() {
    return _repository.find();
  }

}
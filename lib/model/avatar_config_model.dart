class AvatarConfigModel {

  late String avatarConfigData;

  AvatarConfigModel(this.avatarConfigData);

  AvatarConfigModel.fromDatabaseMap(Map<String, dynamic> map) {
    this.avatarConfigData = map['avatar_config_data'];
  }

  Map<String, dynamic> toMap() {
    return {
      'avatar_config_data': avatarConfigData
    };
  }

}
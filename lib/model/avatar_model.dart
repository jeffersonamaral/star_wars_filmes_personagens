class AvatarModel {

  late String avatarData;

  AvatarModel(this.avatarData);

  AvatarModel.fromDatabaseMap(Map<String, dynamic> map) {
    this.avatarData = map['avatar_data'];
  }

  Map<String, dynamic> toMap() {
    return {
      'avatar_data': avatarData
    };
  }

}
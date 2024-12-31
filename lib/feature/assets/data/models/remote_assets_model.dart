import '../../domain/entities/asset_entity.dart';

class RemoteAssetsModel {
  final Map<String, dynamic> json;

  RemoteAssetsModel(this.json);

  factory RemoteAssetsModel.fromJson(Map<String, dynamic> json) {
    return RemoteAssetsModel(json);
  }

  AssetEntity toEntity() {
    return AssetEntity(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
      locationId: json['locationId'],
    );
  }

  static List<AssetEntity> toListEntity(List<Map<String, dynamic>> jsonList) {
    return jsonList
        .map((json) => RemoteAssetsModel.fromJson(json).toEntity())
        .toList();
  }
}
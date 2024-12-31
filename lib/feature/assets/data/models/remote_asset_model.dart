import '../../assests.dart';

class AssetModel {
  final String id;
  final String name;
  final String? sensorType;
  final String? locationId;

  AssetModel({
    required this.id,
    required this.name,
    this.sensorType,
    this.locationId,
  });

  factory AssetModel.fromMap(Map<String, dynamic> map) {
    return AssetModel(
      id: map['id'] as String,
      name: map['name'] as String,
      sensorType: map['sensorType'] as String?,
      locationId: map['locationId'] as String?,
    );
  }

  AssetEntity toEntity() {
    return AssetEntity(
      id: id,
      name: name,
      sensorType: sensorType,
      locationId: locationId ?? '',
    );
  }
}
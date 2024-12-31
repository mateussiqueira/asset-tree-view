import 'package:asset_tree_app/feature/assets/domain/entities/location_entity.dart';

class LocationModel {
  final String id;
  final String name;

  LocationModel({
    required this.id,
    required this.name,
  });

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  LocationEntity toEntity() {
    return LocationEntity(
      id: id,
      name: name,
    );
  }
}
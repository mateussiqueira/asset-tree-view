import '../../assests.dart';
import '../../domain/entities/location_entity.dart';
import 'dart:convert';

class ResponseModel {
  final List<LocationModel> locations;
  final List<AssetModel> assets;

  ResponseModel({
    required this.locations,
    required this.assets,
  });

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      locations: List<LocationModel>.from(
          map['locations']?.map((x) => LocationModel.fromMap(x)) ?? []),
      assets: List<AssetModel>.from(
          map['assets']?.map((x) => AssetModel.fromMap(x)) ?? []),
    );
  }

  factory ResponseModel.fromList(List<dynamic> list) {
    final locationList = list
        .where((item) =>
            item is Map<String, dynamic> &&
            item.containsKey('name') &&
            !item.containsKey('sensorType'))
        .map((item) => LocationModel.fromMap(item))
        .toList();

    final assetList = list
        .where((item) =>
            item is Map<String, dynamic> &&
            item.containsKey('id') &&
            item.containsKey('sensorType'))
        .map((item) => AssetModel.fromMap(item))
        .toList();

    return ResponseModel(
      locations: locationList,
      assets: assetList,
    );
  }

  factory ResponseModel.fromJson(String source) {
    if (source.isEmpty) {
      throw TypeError();
    }

    final decoded = json.decode(source);

    if (decoded == null || (decoded is Map && decoded.isEmpty)) {
      throw TypeError();
    } else if (decoded is Map<String, dynamic>) {
      return ResponseModel.fromMap(decoded);
    } else if (decoded is List) {
      return ResponseModel.fromList(decoded);
    } else {
      throw TypeError();
    }
  }

  List<LocationEntity> toLocationEntities() {
    return locations.map((model) => model.toEntity()).toList();
  }

  List<AssetEntity> toAssetEntities() {
    return assets.map((model) => model.toEntity()).toList();
  }
}
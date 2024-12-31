import '../../assests.dart';
import '../../domain/entities/location_entity.dart';
import 'package:flutter/material.dart';

class AssetTreeView extends StatelessWidget {
  final List<LocationEntity> locations;
  final List<AssetEntity> assets;

  const AssetTreeView({
    super.key,
    required this.locations,
    required this.assets,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final location = locations[index];
        final locationAssets =
            assets.where((asset) => asset.locationId == location.id).toList();
        return ExpansionTile(
          title: Text(location.name),
          children: locationAssets.map((asset) {
            return ListTile(
              title: Text(asset.name),
              subtitle: Text(asset.sensorType ?? 'No sensor'),
            );
          }).toList(),
        );
      },
    );
  }
}
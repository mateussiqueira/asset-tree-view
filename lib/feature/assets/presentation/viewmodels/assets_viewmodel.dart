import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:asset_tree_app/feature/assets/domain/entities/location_entity.dart';
import 'package:asset_tree_app/feature/assets/domain/entities/asset_entity.dart';
import '../../../../core/cache/cache.dart';
import '../../data/repository/api_parser.dart';
import '../../data/services/assets_service.dart';
import '../../data/services/company_service.dart';

class AssetsViewModel extends ChangeNotifier {
  final CompanyService companyService;
  final AssetService assetService;
  final CacheAdapter cacheAdapter;

  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';
  List<LocationEntity> locations = [];
  List<AssetEntity> assets = [];
  List<LocationEntity> filteredLocations = [];
  List<AssetEntity> filteredAssets = [];

  bool isEnergyFilterActive = false;
  bool isCriticalStatusFilterActive = false;
  String searchQuery = '';

  static const cacheValidityDuration = Duration(hours: 1);

  AssetsViewModel({
    required this.companyService,
    required this.assetService,
    required this.cacheAdapter,
  });

  Future<void> loadAssets(String companyId) async {
    try {
      final cachedData = await cacheAdapter.load('assets_$companyId');
      if (cachedData != null) {
        final cachedAssets = json.decode(cachedData);
        if (cachedAssets is Map<String, dynamic> &&
            cachedAssets.containsKey('timestamp')) {
          final cacheTimestamp = DateTime.parse(cachedAssets['timestamp']);
          if (DateTime.now().difference(cacheTimestamp) <
              cacheValidityDuration) {
            final fetchedAssets =
                ApiResponseParser.parseResponse(cachedAssets['data']);
            locations = fetchedAssets.toLocationEntities();
            assets = fetchedAssets.toAssetEntities();
            filteredLocations = List.from(locations);
            filteredAssets = List.from(assets);
            isLoading = false;
            notifyListeners();
            return;
          }
        }
      }

      final fetchedAssets =
          await assetService.fetchLocationsAndAssets(companyId);
      final parsedAssets = ApiResponseParser.parseResponse(fetchedAssets);
      locations = parsedAssets.toLocationEntities();
      assets = parsedAssets.toAssetEntities();
      filteredLocations = List.from(locations);
      filteredAssets = List.from(assets);

      final cacheData = json.encode({
        'timestamp': DateTime.now().toIso8601String(),
        'data': fetchedAssets,
      });
      await cacheAdapter.save('assets_$companyId', cacheData);
      isLoading = false;
    } catch (e) {
      hasError = true;
      errorMessage = 'Failed to load assets: $e';
      isLoading = false;
    }
    notifyListeners();
  }

  void applyTextFilter(String query) {
    searchQuery = query.toLowerCase();
    _applyFilters();
  }

  void toggleEnergySensorFilter() {
    isEnergyFilterActive = !isEnergyFilterActive;
    _applyFilters();
  }

  void toggleCriticalStatusFilter() {
    isCriticalStatusFilterActive = !isCriticalStatusFilterActive;
    _applyFilters();
  }

  void _applyFilters() {
    List<AssetEntity> tempFilteredAssets = List.from(assets);

    if (isEnergyFilterActive) {
      tempFilteredAssets = tempFilteredAssets.where((asset) {
        return asset.sensorType == 'energy';
      }).toList();
    }

    if (isCriticalStatusFilterActive) {
      tempFilteredAssets = tempFilteredAssets.where((asset) {
        return asset.status == 'critical';
      }).toList();
    }

    if (searchQuery.isNotEmpty) {
      tempFilteredAssets = tempFilteredAssets.where((asset) {
        return asset.name.toLowerCase().contains(searchQuery);
      }).toList();
    }

    filteredAssets = tempFilteredAssets;
    filteredLocations = _getLocationsForAssets(filteredAssets);
    notifyListeners();
  }

  List<LocationEntity> _getLocationsForAssets(List<AssetEntity> assets) {
    final locationIds = assets.map((asset) => asset.locationId).toSet();
    return locations.where((location) {
      return locationIds.contains(location.id);
    }).toList();
  }
}

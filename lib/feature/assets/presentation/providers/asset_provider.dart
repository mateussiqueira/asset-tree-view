import '../../../../core/cache/cache.dart';
import '../../data/services/assets_service.dart';
import '../../data/services/company_service.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class AssetProvider extends ChangeNotifier {
  final CompanyService companyService;
  final AssetService assetService;
  final CacheAdapter cacheAdapter;
  AssetProvider({
    required this.companyService,
    required this.assetService,
    required this.cacheAdapter,
  });

  List<dynamic> companies = [];
  List<dynamic> locations = [];
  List<dynamic> assets = [];
  bool isLoading = false;

  static const cacheExpiryDuration = Duration(minutes: 10);

  Future<void> loadCompanies() async {
    if (isLoading) return;

    try {
      isLoading = true;

      final cachedData = await cacheAdapter.load('companies');
      final cachedTimestamp = await cacheAdapter.load('companies_last_updated');

      if (_isCacheValid(cachedTimestamp)) {
        companies = jsonDecode(cachedData!) as List<dynamic>;
        notifyListeners(); // Exibe os dados do cache enquanto busca os novos
      }

      final fetchedCompanies = await companyService.fetchCompanies();
      companies = fetchedCompanies;
      await _updateCache('companies', companies);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadAssets(String companyId) async {
    if (isLoading) return;

    try {
      isLoading = true;

      final cachedLocations = await cacheAdapter.load('locations_$companyId');
      final cachedAssets = await cacheAdapter.load('assets_$companyId');
      final cachedTimestamp =
          await cacheAdapter.load('assets_last_updated_$companyId');

      if (_isCacheValid(cachedTimestamp)) {
        locations = jsonDecode(cachedLocations!) as List<dynamic>;
        assets = jsonDecode(cachedAssets!) as List<dynamic>;
        notifyListeners(); // Exibe os dados do cache enquanto busca os novos
      }

      final data = await assetService.fetchLocationsAndAssets(companyId);
      locations = data['locations'];
      assets = data['assets'];

      await _updateCache('locations_$companyId', locations);
      await _updateCache('assets_$companyId', assets,
          keyTimestamp: 'assets_last_updated_$companyId');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool _isCacheValid(String? cachedTimestamp) {
    if (cachedTimestamp == null) return false;
    final lastUpdated = DateTime.tryParse(cachedTimestamp);
    if (lastUpdated == null) return false;

    final now = DateTime.now();
    return now.difference(lastUpdated) < cacheExpiryDuration;
  }

  Future<void> _updateCache(String key, dynamic data,
      {String? keyTimestamp}) async {
    await cacheAdapter.save(key, jsonEncode(data));
    await cacheAdapter.save(keyTimestamp ?? '${key}_last_updated',
        DateTime.now().toIso8601String());
  }
}
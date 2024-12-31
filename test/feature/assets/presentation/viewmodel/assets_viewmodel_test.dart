// import 'package:asset_tree_app/feature/assets/data/services/assets_service.dart';
// import 'package:asset_tree_app/feature/assets/data/services/company_service.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:asset_tree_app/feature/assets/presentation/viewmodels/assets_viewmodel.dart';
// import 'package:asset_tree_app/core/cache/cache_adapter.dart';

// // Mocks manuais
// class MockCacheAdapter extends Mock implements CacheAdapter {
//   void mockLoad(String key, String? value) {
//     when(() => load(key)).thenAnswer((_) async => value);
//   }

//   void mockSave() {
//     when(() => save(any(), any())).thenAnswer((_) async => true);
//   }
// }

// class MockAssetService extends Mock implements AssetService {
//   void mockFetchLocationsAndAssets(Map<String, dynamic> fetchedAssets) {
//     when(() => fetchLocationsAndAssets(any()))
//         .thenAnswer((_) async => fetchedAssets);
//   }

//   void mockFetchLocationsAndAssetsError(Exception error) {
//     when(() => fetchLocationsAndAssets(any())).thenThrow(error);
//   }
// }

// class MockCompanyService extends Mock implements CompanyService {}

// void main() {
//   late MockCompanyService mockCompanyService;
//   late MockAssetService mockAssetService;
//   late MockCacheAdapter mockCacheAdapter;
//   late AssetsViewModel viewModel;

//   setUp(() {
//     mockCompanyService = MockCompanyService();
//     mockAssetService = MockAssetService();
//     mockCacheAdapter = MockCacheAdapter();
//     viewModel = AssetsViewModel(
//       companyService: mockCompanyService,
//       assetService: mockAssetService,
//       cacheAdapter: mockCacheAdapter,
//     );
//   });

//   group('AssetsViewModel', () {
//     test('initial values are correct', () {
//       expect(viewModel.isLoading, true);
//       expect(viewModel.hasError, false);
//       expect(viewModel.errorMessage, '');
//       expect(viewModel.locations, []);
//       expect(viewModel.assets, []);
//     });

//     test('loadAssets sets locations and assets on success', () async {
//       const companyId = '123';
//       final fetchedAssets = {
//         'locations': [
//           {'id': '1', 'name': 'Location 1'},
//           {'id': '2', 'name': 'Location 2'},
//         ],
//         'assets': [
//           {'id': '1', 'name': 'Asset 1', 'locationId': '1'},
//           {'id': '2', 'name': 'Asset 2', 'locationId': '2'},
//         ],
//       };

//       mockAssetService.mockFetchLocationsAndAssets(fetchedAssets);
//       mockCacheAdapter.mockSave();

//       await viewModel.loadAssets(companyId);

//       expect(viewModel.isLoading, false);
//       expect(viewModel.hasError, false);
//       expect(viewModel.locations.length, 2);
//       expect(viewModel.assets.length, 2);
//       verify(() => mockCacheAdapter.save('assets_$companyId', any())).called(1);
//     });

//     test('loadAssets uses cached data if available', () async {
//       final companyId = '123';
//       final cachedAssets =
//           '{"locations":[{"id":"1","name":"Location 1"},{"id":"2","name":"Location 2"}],"assets":[{"id":"1","name":"Asset 1","locationId":"1"},{"id":"2","name":"Asset 2","locationId":"2"}]}';

//       mockCacheAdapter.mockLoad('assets_$companyId', cachedAssets);

//       await viewModel.loadAssets(companyId);

//       expect(viewModel.isLoading, false);
//       expect(viewModel.hasError, false);
//       expect(viewModel.locations.length, 2);
//       expect(viewModel.assets.length, 2);
//       verifyNever(() => mockAssetService.fetchLocationsAndAssets(any()));
//     });

//     test('loadAssets sets error message on failure', () async {
//       final companyId = '123';
//       final errorMessage = 'Failed to load assets';

//       mockAssetService
//           .mockFetchLocationsAndAssetsError(Exception(errorMessage));

//       await viewModel.loadAssets(companyId);

//       expect(viewModel.isLoading, false);
//       expect(viewModel.hasError, true);
//       expect(viewModel.errorMessage,
//           'Failed to load assets: Exception: $errorMessage');
//     });
//   });
// }

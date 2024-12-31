import '../../../../../core/http/http_adapter.dart';
import 'package:asset_tree_app/core/http/http_methods.dart';

class AssetService {
  final HttpAdapter httpAdapter;
  final String url;

  AssetService({required this.httpAdapter, required this.url});

  Future<Map<String, dynamic>> fetchLocationsAndAssets(String companyId) async {
    final locationsRequest = httpAdapter.request(
      url: '$url/companies/$companyId/locations',
      method: HttpMethod.GET,
    );

    final assetsRequest = httpAdapter.request(
      url: '$url/companies/$companyId/assets',
      method: HttpMethod.GET,
    );

    final results = await Future.wait([locationsRequest, assetsRequest]);

    return {
      'locations': results[0] as List<dynamic>,
      'assets': results[1] as List<dynamic>,
    };
  }
}
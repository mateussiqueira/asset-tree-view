import '../../../../core/core.dart';
import '../../domain/entities/asset_entity.dart';
import '../../domain/interfaces/load_assets.dart';
import '../models/remote_assets_model.dart';

class RemoteLoadAssets implements LoadAssets {
  final HttpAdapter httpAdapter;
  final String url;

  RemoteLoadAssets({
    required this.httpAdapter,
    required this.url,
  });

  @override
  Future<List<AssetEntity>> load() async {
    try {
      final response = await httpAdapter.request(
        url: url,
        method: HttpMethod.GET,
      );

      final List<Map<String, dynamic>> data =
          (response as List<dynamic>).cast<Map<String, dynamic>>();

      return RemoteAssetsModel.toListEntity(data);
    } catch (e) {
      throw Exception('Failed to load assets: $e');
    }
  }
}
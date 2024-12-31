import '../../assests.dart';

abstract class LoadAssets {
  Future<List<AssetEntity>> load();
}
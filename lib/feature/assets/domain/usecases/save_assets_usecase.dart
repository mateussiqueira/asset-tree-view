import '../../assests.dart';

class SaveAssetsUseCase {
  final void Function(List<AssetEntity>) saveAssetsCallback;
  SaveAssetsUseCase(this.saveAssetsCallback);

  void execute(List<AssetEntity> assets) {
    saveAssetsCallback(assets);
  }
}
import '../../../../core/design_system/components/buttons.dart';
import '../../../../core/design_system/components/text_fields.dart';
import '../../../../core/design_system/sizes.dart';
import '../../assests.dart';
import '../viewmodels/assets_viewmodel.dart';
import 'package:asset_tree_app/core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssetsPage extends StatelessWidget {
  final String companyId;

  const AssetsPage({super.key, required this.companyId});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AssetsViewModel(
        companyService: locator.get(),
        assetService: locator.get(),
        cacheAdapter: locator.get(),
      )..loadAssets(companyId),
      child: Scaffold(
        appBar: AppBar(title: const Text('Assets')),
        body: Consumer<AssetsViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSizes.spacingMedium),
                  child: AppTextField(
                    labelText: 'Search',
                    onChanged: (query) {
                      viewModel.applyTextFilter(query);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PrimaryButton(
                      text: 'Energy Sensors',
                      onPressed: () {
                        viewModel.toggleEnergySensorFilter();
                      },
                      isActive: viewModel.isEnergyFilterActive,
                    ),
                    PrimaryButton(
                      text: 'Critical Status',
                      onPressed: () {
                        viewModel.toggleCriticalStatusFilter();
                      },
                      isActive: viewModel.isCriticalStatusFilterActive,
                    ),
                  ],
                ),
                Expanded(
                  child: viewModel.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : viewModel.hasError
                          ? Center(
                              child: Text(
                                viewModel.errorMessage,
                                style: const TextStyle(color: Colors.red),
                              ),
                            )
                          : AssetTreeView(
                              locations: viewModel.filteredLocations,
                              assets: viewModel.filteredAssets,
                            ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
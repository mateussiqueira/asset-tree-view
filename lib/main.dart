import 'core/di/di.dart';
import 'feature/assets/assests.dart';
import 'feature/assets/presentation/viewmodels/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const AssetTreeApp());
}

class AssetTreeApp extends StatelessWidget {
  const AssetTreeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AssetProvider(
            companyService: locator.get(),
            assetService: locator.get(),
            cacheAdapter: locator.get(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AssetsViewModel(
            companyService: locator.get(),
            assetService: locator.get(),
            cacheAdapter: locator.get(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'AssetTree',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const HomePage(),
      ),
    );
  }
}
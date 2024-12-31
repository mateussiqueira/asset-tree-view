import '../../assests.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore_for_file: library_private_types_in_public_api

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<void> _loadCompaniesFuture;

  @override
  void initState() {
    super.initState();
    _loadCompaniesFuture =
        Provider.of<AssetProvider>(context, listen: false).loadCompanies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Companies')),
      body: FutureBuilder<void>(
        future: _loadCompaniesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Failed to load companies. Please try again.',
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          return Consumer<AssetProvider>(
            builder: (context, provider, child) {
              return ListView.builder(
                itemCount: provider.companies.length,
                itemBuilder: (context, index) {
                  final company = provider.companies[index];
                  return ListTile(
                    title: Text(company['name']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AssetsPage(
                            companyId: company['id'],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
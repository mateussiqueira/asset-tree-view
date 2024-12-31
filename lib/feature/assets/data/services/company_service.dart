import '../../../../core/core.dart';

class CompanyService {
  final HttpAdapter httpAdapter;
  final String url;
  CompanyService({required this.httpAdapter, required this.url});

  Future<List<dynamic>> fetchCompanies() async {
    final response = await httpAdapter.request(
      url: "$url/companies",
      method: HttpMethod.GET,
    );
    return response as List<dynamic>;
  }
}
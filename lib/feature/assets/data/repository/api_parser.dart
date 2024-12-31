import 'dart:convert';
import 'package:asset_tree_app/feature/assets/data/models/response_model.dart';

class ApiResponseParser {
  static ResponseModel parseResponse(dynamic response) {
    if (response is String) {
      final decoded = json.decode(response);
      if (decoded is Map<String, dynamic>) {
        return ResponseModel.fromMap(decoded);
      } else if (decoded is List) {
        return ResponseModel.fromList(decoded);
      } else {
        throw TypeError();
      }
    } else if (response is Map<String, dynamic>) {
      return ResponseModel.fromMap(response);
    } else {
      throw TypeError();
    }
  }
}
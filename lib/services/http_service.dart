import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:otk_employee/services/storage_service.dart';
import 'package:get/get.dart';

enum Result { success, error }

class Api {
  static String baseUrl = "176.124.208.61:2005";
  static String middle = "api/qualityController";
  static String login = "api/login";
  static String orders = "$middle/orders";
  static String qualityDescription = "$middle/qualityDescription";
  static String qualityCheck = "$middle/qualityCheck";
}

class HttpService {
  static Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? param,
  }) async {
    String token = StorageService.read("token") ?? "";

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    }..addAllIf(
        token.isNotEmpty,
        {"Authorization": "Bearer $token"},
      );
    Uri url = Uri.http(Api.baseUrl, endpoint, param);

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'data': jsonDecode(response.body),
          'status': Result.success,
        };
      } else {
        log("Error [GET]: ${response.body}");
        return {
          'status': Result.error,
        };
      }
    } catch (e) {
      log("Error: $e");
      return {
        'status': Result.error,
      };
    }
  }

  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    String token = StorageService.read("token") ?? "";

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }..addAllIf(
        token.isNotEmpty,
        {"Authorization": "Bearer $token"},
      );

    Uri url = Uri.http(Api.baseUrl, endpoint);
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'data': jsonDecode(response.body),
          'status': Result.success,
        };
      } else {
        log("Error [POST]: ${response.body}");

        return {
          'status': Result.error,
        };
      }
    } catch (e) {
      log("Error: $e");
      return {
        'status': Result.error,
      };
    }
  }

  static Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    String token = StorageService.read("token") ?? "";

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    }..addAllIf(
        token.isNotEmpty,
        {"Authorization": "Bearer $token"},
      );

    Uri url = Uri.http(Api.baseUrl, endpoint);
    try {
      final response = await http.put(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'data': jsonDecode(response.body),
          'status': Result.success,
        };
      } else {
        log("Error [PUT]: ${response.body}");
        return {
          'status': Result.error,
        };
      }
    } catch (e) {
      log("Error: $e");
      return {
        'status': Result.error,
      };
    }
  }

  static Future<Map<String, dynamic>> patch(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    String token = StorageService.read("token") ?? "";

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    }..addAllIf(
        token.isNotEmpty,
        {"Authorization": "Bearer $token"},
      );

    Uri url = Uri.http(Api.baseUrl, endpoint);
    try {
      final response = await http.patch(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'data': jsonDecode(response.body),
          'status': Result.success,
        };
      } else {
        log("Error [PATCH]: ${response.body}");

        return {
          'status': Result.error,
        };
      }
    } catch (e) {
      log("Error: $e");
      return {
        'status': Result.error,
      };
    }
  }

  static Future<Map<String, dynamic>> delete(String endpoint) async {
    String token = StorageService.read("token") ?? "";

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    }..addAllIf(
        token.isNotEmpty,
        {"Authorization": "Bearer $token"},
      );

    Uri url = Uri.http(Api.baseUrl, endpoint);
    try {
      final response = await http.delete(url, headers: headers);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'data': jsonDecode(response.body),
          'status': Result.success,
        };
      } else {
        log("Error [DELETE]: ${response.body}");

        return {
          'status': Result.error,
        };
      }
    } catch (e) {
      log("Error: $e");
      return {
        'status': Result.error,
      };
    }
  }

  static Future<Map<String, dynamic>> upload(
    String endpoint, {
    required Map<String, dynamic> body,
  }) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
      }..addAllIf(StorageService.read("token") != null, {"Authorization": "Bearer ${StorageService.read("token")}"});

      // API endpoint
      final url = Uri.http(Api.baseUrl, endpoint);

      var request = http.MultipartRequest('post', url);

      request.headers.addAll(headers);

      if (body.containsKey("image")) {
        request.files.add(await http.MultipartFile.fromPath('image', body['image']));

        body.remove('image');
      }

      request.fields['data'] = jsonEncode(body);

      var res = await request.send();

      if (res.statusCode >= 200 && res.statusCode < 300) {
        return {
          'data': jsonDecode(await res.stream.bytesToString()),
          'status': Result.success,
        };
      } else {
        log('Error: ${await res.stream.bytesToString()}');
        return {
          'status': Result.error,
        };
      }
    } catch (e) {
      log('Error: $e');
      return {
        'status': Result.error,
      };
    }
  }
}

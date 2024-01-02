import 'dart:convert';
import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:user_side/data/netword/api_urls.dart';
import 'package:user_side/data/shared_preference/shared_prefence.dart';
import 'package:user_side/utils/app_exceptions.dart';

typedef EitherResponse = Future<Either<AppExceptions, dynamic>>;

class ApiService {
  static Map<String, String> header = {"Content-Type": "application/json"};

  static EitherResponse getApi(String url, [String? token]) async {
    if (token != null) {
      header["Authorization"] = "Bearer $token";
      header["Cookie"] = 'jwt=$token';
      header["Content-Type"] = 'application/json';
    }
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri, headers: header);
      final body = getResponse(response);
      return Right(body);
    } on SocketException {
      return Left(InterntExceptions());
    } on http.ClientException {
      return Left(BadRequestExceptions());
    } catch (e) {
      return Left(RequestTimeOutExceptions());
    }
  }

  static EitherResponse postApi(var data, String url, [String? token]) async {
    if (token != null) {
      header["Authorization"] = "Bearer $token";
      header["Cookie"] = 'jwt=$token';
    }
    final uri = Uri.parse(url);
    final body = jsonEncode(data);
    try {
      final response = await http.post(uri, body: body, headers: header);
      final responseBody = getResponse(response);
      return Right(responseBody);
    } on SocketException {
      return Left(InterntExceptions());
    } on http.ClientException {
      return Left(BadRequestExceptions());
    } catch (e) {
      return Left(RequestTimeOutExceptions());
    }
  }

  static EitherResponse patchApi(var data, String url, [String? token]) async {
    if (token != null) {
      header["Authorization"] = "Bearer $token";
      header["Cookie"] = 'jwt=$token';
    }
    final uri = Uri.parse(url);
    final body = jsonEncode(data);
    try {
      final response = await http.patch(
        uri,
        body: body,
        headers: header,
      );
      Map<String, dynamic> responseBody = getResponse(response);
      return Right(responseBody);
    } on SocketException {
      return Left(InterntExceptions());
    } on http.ClientException {
      return Left(BadRequestExceptions());
    } catch (e) {
      return Left(RequestTimeOutExceptions());
    }
  }

  static EitherResponse deleteApi(String url, [String? token]) async {
    if (token != null) {
      header["Authorization"] = "Bearer $token";
      header["Cookie"] = 'jwt=$token';
    }
    final uri = Uri.parse(url);
    try {
      final response = await http.delete(
        uri,
        headers: header,
      );
      final responseBody = getResponse(response);
      return Right(responseBody);
    } on SocketException {
      return Left(InterntExceptions());
    } on http.ClientException {
      return Left(BadRequestExceptions());
    } catch (e) {
      return Left(RequestTimeOutExceptions());
    }
  }

  static EitherResponse putApi(var data, String url, [String? token]) async {
    if (token != null) {
      header["Authorization"] = "Bearer $token";
      header["Cookie"] = 'jwt=$token';
    }
    final uri = Uri.parse(url);
    final body = jsonEncode(data);

    try {
      final response = await http.put(
        uri,
        body: body,
        headers: header,
      );
      final responseBody = getResponse(response);
      return Right(responseBody);
    } on SocketException {
      return Left(InterntExceptions());
    } on http.ClientException {
      return Left(BadRequestExceptions());
    } catch (e) {
      return Left(RequestTimeOutExceptions());
    }
  }

  Future<http.StreamedResponse> profileUpdate(File image) async {
    final token = SharedPref.instance.getToke();
    final url = Uri.parse("${ApiUrls.baseUrl}/${ApiUrls.updateProfile}");
    var request = http.MultipartRequest('PATCH', url);
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Cookie'] = 'jwt=$token';
    var profilePhotoStream = http.ByteStream(image.openRead());
    var profilePhotoLength = await image.length();
    var profilePhotoMultipartFile = http.MultipartFile(
      'profile',
      profilePhotoStream,
      profilePhotoLength,
      filename: 'profilephoto.jpg',
    );
    request.files.add(profilePhotoMultipartFile);
    final response = await request.send();
    return response;
  }

  Future<http.Response> dataUpdate(Map<String, dynamic> data) async {
    final url = Uri.parse("${ApiUrls.baseUrl}/${ApiUrls.updateUser}");
    final token = SharedPref.instance.getToke();
    final header = {
      'Authorization': 'Bearer $token',
      'Cookie': 'jwt=$token',
      'Content-Type': 'application/json'
    };

    final body = jsonEncode(data);
    final response = await http.patch(url, body: body, headers: header);
    return response;
  }

  static getResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      throw BadRequestExceptions();
    } else if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw BadRequestExceptions();
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:breath_better_bnb_marathon/core/enum/global_keys.dart';
import 'package:breath_better_bnb_marathon/core/error/exceptions.dart';
import 'package:breath_better_bnb_marathon/core/extensions/map_extensions.dart';
import 'package:breath_better_bnb_marathon/core/network/network_info.dart';
import 'package:breath_better_bnb_marathon/core/network/network_io_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NetworkIOServiceImpl implements NetworkIOService {
  final http.Client client;
  final NetworkInfo networkInfo;

  NetworkIOServiceImpl({required this.client, required this.networkInfo});

  @override
  Future<String> get(String url, {Map<String, String> queryParams = const {}, ContentType contentType = ContentType.json, Map<String, String> headers = const {}}) async {
    if (!(await networkInfo.isConnected)) {
      throw NoInternetError();
    }

    String queryString = '';
    if (queryParams.isNotEmpty) {
      Map<String, String> parsedQueryParameters =
          Uri.parse(url).queryParameters;
      queryParams.addAll(parsedQueryParameters);
      queryString = Uri(queryParameters: queryParams).query;
    }

    // Create a mutable copy of headers and set the content type
    final customHeaders = headers.withContentType(contentType);

    final response = await client.get(
        Uri.parse(queryParams.isNotEmpty ? "$url?$queryString" : url),
        headers: customHeaders);

    debugPrint("Network HttpCode: ${response.statusCode}");
    debugPrint("Network ResponseBody: ${response.body}");

    if (response.statusCode == HttpStatus.ok) {
      return utf8.decode(response.bodyBytes); //to escape special chars
    } else {
      if (response.statusCode == HttpStatus.unauthorized ||
          response.statusCode == HttpStatus.forbidden) {
        return throw InvalidTokenError();
      }
      return throw BackendHardError(
          response.statusCode, "Something went wrong please try again.");
    }
  }

  @override
  Future<String> post(String url, {dynamic requestData, ContentType contentType = ContentType.json, Map<String, String> headers = const {}})  async{
    if (!(await networkInfo.isConnected)) {
      throw NoInternetError();
    }

    debugPrint("Network URL :$url");
    debugPrint("Network Request :$requestData");

    /// Create a mutable copy of headers and set the content type
    final customHeaders = headers.withContentType(contentType);

    // Now add additional headers as needed
    /** Use the below code to add additional headers to your request like bearer token etc
        headers['Authorization'] = 'Bearer your_access_token';
        headers['Custom-Header'] = 'CustomHeaderValue';*/
    debugPrint("Headers: $customHeaders");

    final response = await client.post(
      Uri.parse(url),
      headers: customHeaders,
      body: contentType == ContentType.formUrlEncoded
          ? requestData // Send as is for formUrlEncoded (expects Map<String, String>)
          : json.encode(requestData), // Encode as JSON if contentType is json,
    );

    debugPrint("Network HttpCode: ${response.statusCode}");
    debugPrint("Network ResponseBody: ${response.body}");

    if (response.statusCode == HttpStatus.ok) {
      return utf8.decode(response.bodyBytes);
    } else if (response.statusCode == HttpStatus.conflict){
      return utf8.decode(response.bodyBytes);
    } else {
      if (response.statusCode == HttpStatus.unauthorized ||
          response.statusCode == HttpStatus.forbidden) {
        throw InvalidTokenError();
      }
      throw BackendHardError(
          response.statusCode, "Something went wrong, please try again.");
    }
  }
}

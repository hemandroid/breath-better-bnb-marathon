import 'package:breath_better_bnb_marathon/core/enum/global_keys.dart';

abstract class NetworkIOService {
  Future<String> get(String url, {Map<String, String> queryParams, ContentType contentType, Map<String, String> headers});

  Future<String> post(String url, {dynamic requestData, ContentType contentType, Map<String, String> headers});

}

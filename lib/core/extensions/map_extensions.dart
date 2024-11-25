import 'package:breath_better_bnb_marathon/core/enum/global_keys.dart';

extension ContentTypeHeader on Map<String, String> {
  Map<String, String> withContentType(ContentType contentType) {
    // Create a copy of the map, modify it, and return it
    Map<String, String> newHeaders = Map.from(this);
    switch (contentType) {
      case ContentType.json:
        newHeaders['Content-Type'] = 'application/json';
        break;
      case ContentType.formUrlEncoded:
        newHeaders['Content-Type'] = 'application/x-www-form-urlencoded';
        break;
      case ContentType.textPlain:
        newHeaders['Content-Type'] = 'text/plain';
        break;
    }
    return newHeaders;
  }
}

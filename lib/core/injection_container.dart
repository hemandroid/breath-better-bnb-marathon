import 'package:breath_better_bnb_marathon/core_impl/network_io_service_impl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core_impl/network_info_impl.dart';

final httpClientProvider = Provider((ref) => http.Client());

final connectivityServiceProvider = Provider((ref) => NetworkIOServiceImpl(
    client: ref.read(httpClientProvider),
    networkInfo: ref.read(networkInfoImplProvider)));
    // Here we have networkInfoImplProvider which handles the connectivity checks
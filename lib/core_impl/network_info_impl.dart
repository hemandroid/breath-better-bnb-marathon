import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../core/network/network_info.dart';

part 'network_info_impl.g.dart';

@riverpod
class NetworkInfoImpl extends _$NetworkInfoImpl implements NetworkInfo {
  Connectivity? connectionChecker;

  // Default constructor as required by riverpod
  NetworkInfoImpl();

  // Named constructor to initialize connectionChecker
  NetworkInfoImpl.withConnectionChecker(this.connectionChecker);

  @override
  Future<bool> get isConnected async => (await connectionChecker?.checkConnectivity()) != ConnectivityResult.none;

  @override
  NetworkInfo build() => this;
}

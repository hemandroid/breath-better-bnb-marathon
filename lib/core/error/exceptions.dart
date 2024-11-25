class BaseException implements Exception {
  int? code;
  String? message;

  BaseException(this.code, this.message);
}

class BackendHardError extends BaseException {
  BackendHardError(super.code, super.message);
}

class BackendSoftError extends BaseException {
  BackendSoftError(super.code, super.message);
}

class NoInternetError extends BaseException {
  NoInternetError() : super(0, 'No internet connection');
}

class InvalidTokenError extends BaseException {
  InvalidTokenError() : super(0, 'Please login and try again.');
}
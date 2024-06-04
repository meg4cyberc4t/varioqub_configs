import 'package:varioqub_configs/src/varioqub_api_pigeon.g.dart';

abstract interface class VarioqubException implements Exception {}

class VarioqubFetchException implements VarioqubException {
  const VarioqubFetchException({
    required this.error,
    required this.message,
  });

  final String? message;
  final VarioqubFetchError error;
}

enum VarioqubFetchError {
  emptyResult,
  identifiersNull,
  responseParseError,
  requestThrottled,
  networkError,
  internalError,
}

/// @nodoc
extension VarioqubFetchErrorPigeonConverter on VarioqubFetchError {
  static VarioqubFetchError fromPigeon(final VarioqubFetchErrorPigeon value) =>
      switch (value) {
        VarioqubFetchErrorPigeon.emptyResult => VarioqubFetchError.emptyResult,
        VarioqubFetchErrorPigeon.identifiersNull =>
          VarioqubFetchError.identifiersNull,
        VarioqubFetchErrorPigeon.responseParseError =>
          VarioqubFetchError.responseParseError,
        VarioqubFetchErrorPigeon.requestThrottled =>
          VarioqubFetchError.requestThrottled,
        VarioqubFetchErrorPigeon.networkError =>
          VarioqubFetchError.networkError,
        VarioqubFetchErrorPigeon.internalError =>
          VarioqubFetchError.internalError,
      };
}

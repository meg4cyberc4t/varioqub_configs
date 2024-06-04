// Copyright 2024 Igor Molchanov. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:pigeon/pigeon.dart';

// #docregion config
@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/varioqub_api_pigeon.g.dart',
    dartOptions: DartOptions(),
    kotlinOut:
        'android/src/main/kotlin/com/meg4cyberc4t/varioqub_configs/Messages.g.kt',
    kotlinOptions: KotlinOptions(
      errorClassName: 'FlutterError',
      package: 'com.meg4cyberc4t.varioqub_configs',
    ),
    swiftOut: 'ios/Classes/Messages.g.swift',
    swiftOptions: SwiftOptions(),
    copyrightHeader: 'pigeons/copyright.txt',
    dartPackageName: 'varioqub_configs',
  ),
)
// #enddocregion config

// #docregion host-definitions
// Mirror of com.yandex.varioqub.config
final class VarioqubSettingsPigeon {
  final String clientId;
  final String? url;
  final int? fetchThrottleIntervalMs;
  final bool? logs;
  final bool? activateEvent;
  final bool trackingWithAppMetrica;

  // Generic type parameters must be nullable in
  // field "clientFeatures" in class.
  final Map<String?, String?> clientFeatures;

  const VarioqubSettingsPigeon({
    required this.clientId,
    required this.trackingWithAppMetrica,
    this.url,
    this.fetchThrottleIntervalMs,
    this.logs,
    this.activateEvent,
    this.clientFeatures = const {},
  });
}

// Mirror of com.yandex.varioqub.config.FetchError
enum VarioqubFetchErrorPigeon {
  emptyResult,
  identifiersNull,
  responseParseError,
  requestThrottled,
  networkError,
  internalError,
}

// Mirror of com.yandex.varioqub.config.OnFetchCompleteListener.onError
final class FetchErrorPigeon {
  const FetchErrorPigeon({
    required this.error,
    required this.message,
  });

  final String? message;
  final VarioqubFetchErrorPigeon error;
}

// Mirror of com.yandex.varioqub.config.VarioqubApi
@HostApi()
abstract class VarioqubApiPigeon {
  // Initialization of the project, transfer of data for authorization
  // to Varioqub, list of client features, other settings.
  void build(final VarioqubSettingsPigeon settings);

  // Extracting the config from the Varioqub servers.
  // It will return FetchErrorPigeon if a certain error was caught during
  // the process, or it will return null if everything
  // is completed successfully.
  @async
  FetchErrorPigeon? fetchConfig();

  @async
  void activateConfig();

  String getString({
    required final String key,
    required final String defaultValue,
  });

  bool getBool({
    required final String key,
    required final bool defaultValue,
  });

  int getInt({
    required final String key,
    required final int defaultValue,
  });

  double getDouble({
    required final String key,
    required final double defaultValue,
  });

  String getId();

  List<String> getAllKeys();

  Map<String, String> getAllValues();

  void setDefaults(final Map<String, Object> values);

  void putClientFeature({
    required final String key,
    required final String value,
  });

  void clearClientFeatures();
}
// #enddocregion host-definitions

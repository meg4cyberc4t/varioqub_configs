// Copyright 2024 Igor Molchanov. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:pigeon/pigeon.dart';

// #docregion config
@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages.g.dart',
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

final class ConfigData {
  final String oldConfigVersion;
  final String newConfigVersion;
  final int configLoadTimestamp;
  const ConfigData({
    required this.configLoadTimestamp,
    required this.newConfigVersion,
    required this.oldConfigVersion,
  });
}

enum PigeonAdapterMode {
  appmetrica,
  none,
}

final class PigeonBuildSettings {
  final String clientId;
  final PigeonAdapterMode adapterMode;
  final Map<String?, String?> clientFeatures;
  final bool? logs;
  final bool activateEvent;

  const PigeonBuildSettings({
    required this.clientId,
    required this.adapterMode,
    this.clientFeatures = const {},
    this.logs,
    this.activateEvent = true,
  });
}

@HostApi()
abstract class VarioqubSender {
  void build(final PigeonBuildSettings settings);

  @async
  void fetchConfig();

  @async
  void activateConfig();

  void setDefaults(final Map<String, Object> values);

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

  void putClientFeature({
    required final String key,
    required final String value,
  });

  void clearClientFeatures();

  List<String> getAllKeys();
}
// #enddocregion host-definitions

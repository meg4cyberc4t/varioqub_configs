import 'dart:convert';

import 'package:varioqub_configs/src/build_settings/adapter_mode.dart';
import 'package:varioqub_configs/src/messages.g.dart';
import 'package:varioqub_configs/varioqub_configs.dart';

/// @nodoc
const buildSettingsCodec = _BuildSettingsCodec();

class _BuildSettingsCodec extends Codec<BuildSettings, PigeonBuildSettings> {
  const _BuildSettingsCodec();

  @override
  Converter<PigeonBuildSettings, BuildSettings> get decoder =>
      const _BuildSettingsDecoderConverter();

  @override
  Converter<BuildSettings, PigeonBuildSettings> get encoder =>
      const _BuildSettingsEncoderConverter();
}

final class _BuildSettingsEncoderConverter
    extends Converter<BuildSettings, PigeonBuildSettings> {
  const _BuildSettingsEncoderConverter();

  @override
  PigeonBuildSettings convert(final BuildSettings input) => PigeonBuildSettings(
        adapterMode: switch (input.client.adapterMode) {
          VarioqubAdapterMode.appmetrica => PigeonAdapterMode.appmetrica,
          VarioqubAdapterMode.none => PigeonAdapterMode.none,
        },
        activateEvent: input.activateEvent,
        clientFeatures: input.clientFeatures,
        clientId: input.client.id,
        logs: input.logs,
      );
}

final class _BuildSettingsDecoderConverter
    extends Converter<PigeonBuildSettings, BuildSettings> {
  const _BuildSettingsDecoderConverter();

  @override
  BuildSettings convert(final PigeonBuildSettings input) {
    final Map<String, String> clientFeatures = {};

    for (final feature in input.clientFeatures.entries) {
      if (feature.key != null && feature.value != null) {
        clientFeatures[feature.key!] = feature.value!;
      }
    }

    return BuildSettings(
      activateEvent: input.activateEvent,
      client: VarioqubClient.raw(input.clientId),
      clientFeatures: clientFeatures,
      logs: input.logs,
    );
  }
}

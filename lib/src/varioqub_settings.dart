// #docregion host-definitions
// Mirror of com.yandex.varioqub.config
import 'package:varioqub_configs/src/varioqub_api_pigeon.g.dart';

final class VarioqubSettings {
  final String clientId;
  final String? url;
  final int? fetchThrottleIntervalMs;
  final bool? logs;
  final bool? activateEvent;
  final Map<String, String> clientFeatures;
  final bool trackingWithAppMetrica;

  const VarioqubSettings({
    required this.clientId,
    this.url,
    this.fetchThrottleIntervalMs,
    this.logs,
    this.activateEvent,
    this.clientFeatures = const {},
    this.trackingWithAppMetrica = false,
  });
}

/// @nodoc
extension VarioqubSettingsPigeonConverter on VarioqubSettings {
  VarioqubSettingsPigeon toPigeon() => VarioqubSettingsPigeon(
        url: url,
        clientFeatures: clientFeatures,
        clientId: clientId,
        activateEvent: activateEvent,
        fetchThrottleIntervalMs: fetchThrottleIntervalMs,
        logs: logs,
        trackingWithAppMetrica: trackingWithAppMetrica,
      );
}

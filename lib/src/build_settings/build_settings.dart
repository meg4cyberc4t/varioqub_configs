import 'package:varioqub_configs/src/build_settings/adapter_mode.dart';

/// {@template BuildSettings}
/// Initialization settings for Varioqub
/// {@endtemplate}
final class BuildSettings {
  /// {@macro VarioqubClient}
  final VarioqubClient client;

  /// Containing a list of custom parameters. For example,
  /// you can pass a flag indicating if the user is subscribed
  /// to newsletters.
  final Map<String, String> clientFeatures;

  /// Turn on the internal logging. We recommend that you turn the logging
  /// on and use the resulting logs together with the issue description
  /// when contacting the support team.
  final bool? logs;

  /// Send the event when flags are activated.
  /// By default the event sending is enabled.
  final bool activateEvent;

  /// {@macro BuildSettings}
  const BuildSettings({
    required this.client,
    this.clientFeatures = const {},
    this.logs,
    this.activateEvent = true,
  });
}

/// {@template VarioqubClient}
/// Classes for authorization in Varioqub
/// {@endtemplate}
sealed class VarioqubClient {
  const VarioqubClient();

  /// Authorization in Varioqub via AppMetrica
  ///
  /// [appId] - number of your application in AppMetrica.
  /// You can find it in Settings -> Application ID
  factory VarioqubClient.appmetrica(
    final String appId, {
    final VarioqubAdapterMode adapterMode = VarioqubAdapterMode.appmetrica,
  }) =>
      _BuildSettingsClient$AppMetrica(
        appId,
        adapterMode: adapterMode,
      );

  /// Authorization by passing a direct id to Varioqub
  const factory VarioqubClient.raw(final String id) = _BuildSettingsClient$Raw;

  /// Key for authorization
  abstract final String id;

  /// {@macro VarioqubAdapterMode}
  abstract final VarioqubAdapterMode adapterMode;
}

final class _BuildSettingsClient$AppMetrica extends VarioqubClient {
  const _BuildSettingsClient$AppMetrica(
    this.appId, {
    this.adapterMode = VarioqubAdapterMode.appmetrica,
  });

  final String appId;

  @override
  String get id => 'appmetrica.$appId';

  @override
  final VarioqubAdapterMode adapterMode;
}

final class _BuildSettingsClient$Raw extends VarioqubClient {
  const _BuildSettingsClient$Raw(this.id);

  @override
  final String id;

  @override
  VarioqubAdapterMode get adapterMode => VarioqubAdapterMode.none;
}

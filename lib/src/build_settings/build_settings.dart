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
  const factory VarioqubClient.appmetrica(final String appId) =
      _BuildSettingsClient$AppMetrica;

  /// Authorization by passing a direct id to Varioqub
  const factory VarioqubClient.raw(final String id) = _BuildSettingsClient$Raw;

  /// Key for authorization
  String get id;
}

final class _BuildSettingsClient$AppMetrica extends VarioqubClient {
  const _BuildSettingsClient$AppMetrica(this.appId);

  final String appId;

  @override
  String get id => 'appmetrica.$appId';
}

final class _BuildSettingsClient$Raw extends VarioqubClient {
  const _BuildSettingsClient$Raw(this.id);

  @override
  final String id;
}

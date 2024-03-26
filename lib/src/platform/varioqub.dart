import 'package:varioqub_configs/src/build_settings/build_settings_codec.dart';
import 'package:varioqub_configs/src/messages.g.dart';
import 'package:varioqub_configs/varioqub_configs.dart';

/// {@template VarioqubConfigs}
/// Flutter plugin providing work with remote configs,
/// experiments and A/B testing via Varioqub.
/// {@endtemplate}
abstract interface class VarioqubConfigs {
  /// {@macro VarioqubConfigs}
  factory VarioqubConfigs() => _VarioqubPlatform();

  /// Initializing settings for VarioqubConfigs
  Future<void> build(
    final BuildSettings settings,
  );

  /// Method to get the stored flag values.
  ///
  /// Do not activate the configs in progress of the running application,
  /// this may not lead to consistent operation.
  Future<void> activateConfig();

  /// Getting configs from the server.
  /// Upon successful receipt of configs, you can initialize this at the
  /// beginning of the next session via [activateConfig]
  Future<void> fetchConfig();

  /// The device identifier (ID) can be used when checking the experiment.
  /// To do this, specify it in the appropriate field in A/B experiments.
  Future<String> getId();

  /// Adding default values
  Future<void> setDefaults(final Map<String, Object> values);

  /// Providing client features for analytics
  Future<void> putClientFeature({
    required final String key,
    required final String value,
  });

  /// Clearing client features for analytics
  Future<void> clearClientFeatures();

  /// Getting the config value with the string type.
  Future<String> getString({
    required final String key,
    required final String defaultValue,
  });

  /// Getting the config value with the bool type.
  Future<bool> getBool({
    required final String key,
    required final bool defaultValue,
  });

  /// Getting the config value with the int type.
  Future<int> getInt({
    required final String key,
    required final int defaultValue,
  });

  /// Getting the config value with the double type.
  Future<double> getDouble({
    required final String key,
    required final double defaultValue,
  });
}

final class _VarioqubPlatform implements VarioqubConfigs {
  static final _VarioqubPlatform _instance = _VarioqubPlatform._();
  factory _VarioqubPlatform() => _instance;

  final VarioqubSender _sender;

  _VarioqubPlatform._() : _sender = VarioqubSender();

  @override
  Future<void> build(
    final BuildSettings settings,
  ) async =>
      _sender.build(
        buildSettingsCodec.encode(settings),
      );

  @override
  Future<void> activateConfig() async => _sender.activateConfig();

  @override
  Future<void> fetchConfig() async => _sender.fetchConfig();

  @override
  Future<String> getId() async => _sender.getId();

  @override
  Future<String> getString({
    required final String key,
    required final String defaultValue,
  }) =>
      _sender.getString(key: key, defaultValue: defaultValue);

  @override
  Future<bool> getBool({
    required final String key,
    required final bool defaultValue,
  }) =>
      _sender.getBool(key: key, defaultValue: defaultValue);

  @override
  Future<int> getInt({
    required final String key,
    required final int defaultValue,
  }) =>
      _sender.getInt(key: key, defaultValue: defaultValue);

  @override
  Future<double> getDouble({
    required final String key,
    required final double defaultValue,
  }) =>
      _sender.getDouble(key: key, defaultValue: defaultValue);

  @override
  Future<void> setDefaults(final Map<String, Object> values) =>
      _sender.setDefaults(values);

  @override
  Future<void> putClientFeature({
    required final String key,
    required final String value,
  }) =>
      _sender.putClientFeature(key: key, value: value);

  @override
  Future<void> clearClientFeatures() => _sender.clearClientFeatures();
}

import 'package:varioqub_configs/src/messages.g.dart';
import 'package:varioqub_configs/varioqub_configs.dart';

abstract interface class VarioqubConfigs {
  factory VarioqubConfigs() => _VarioqubPlatform();

  Future<void> build(
    final BuildSettings settings,
  );

  Future<void> activateConfig();

  Future<void> fetchConfig();

  Future<String> getId();

  Future<String> getString({
    required final String key,
    required final String defaultValue,
  });

  Future<bool> getBool({
    required final String key,
    required final bool defaultValue,
  });

  Future<int> getInt({
    required final String key,
    required final int defaultValue,
  });

  Future<double> getDouble({
    required final String key,
    required final double defaultValue,
  });

  Future<void> setDefaults(final Map<String, Object> values);

  Future<void> putClientFeature({
    required final String key,
    required final String value,
  });

  Future<void> clearClientFeatures();
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
      _sender.build(settings.toPigeon());

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

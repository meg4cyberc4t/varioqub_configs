import 'package:varioqub_configs/src/exceptions.dart';
import 'package:varioqub_configs/src/varioqub_api_pigeon.g.dart';
import 'package:varioqub_configs/src/varioqub_settings.dart';

/// {@template VarioqubConfigs}
/// Flutter plugin providing work with remote configs,
/// experiments and A/B testing via Varioqub.
/// {@endtemplate}
abstract final class Varioqub {
  /// {@macro VarioqubConfigs}
  const Varioqub._();

  static final VarioqubApiPigeon _varioqubApi = VarioqubApiPigeon();

  /// Initializing settings for VarioqubConfigs
  static Future<void> build(final VarioqubSettings settings) =>
      _varioqubApi.build(settings.toPigeon());

  /// Method to get the stored flag values.
  ///
  /// Do not activate the configs in progress of the running application,
  /// this may not lead to consistent operation.
  static Future<void> activateConfig() async => _varioqubApi.activateConfig();

  /// Getting configs from the server.
  /// Upon successful receipt of configs, you can initialize this at the
  /// beginning of the next session via [activateConfig]
  static Future<void> fetchConfig() async {
    final FetchErrorPigeon? fetchError = await _varioqubApi.fetchConfig();
    if (fetchError != null) {
      throw VarioqubFetchException(
        error: VarioqubFetchErrorPigeonConverter.fromPigeon(fetchError.error),
        message: fetchError.message,
      );
    }
  }

  /// The device identifier (ID) can be used when checking the experiment.
  /// To do this, specify it in the appropriate field in A/B experiments.
  static Future<String> getId() => _varioqubApi.getId();

  /// Adding default values
  static Future<void> setDefaults(final Map<String, Object> values) async =>
      _varioqubApi.setDefaults(values);

  /// Providing client features for analytics
  static Future<void> putClientFeature({
    required final String key,
    required final String value,
  }) async =>
      _varioqubApi.putClientFeature(key: key, value: value);

  /// Clearing client features for analytics
  static Future<void> clearClientFeatures() async =>
      _varioqubApi.clearClientFeatures();

  /// Getting the config value with the string type.
  static Future<String> getString({
    required final String key,
    required final String defaultValue,
  }) async =>
      _varioqubApi.getString(key: key, defaultValue: defaultValue);

  /// Getting the config value with the bool type.
  static Future<bool> getBool({
    required final String key,
    required final bool defaultValue,
  }) async =>
      _varioqubApi.getBool(key: key, defaultValue: defaultValue);

  /// Getting the config value with the int type.
  static Future<int> getInt({
    required final String key,
    required final int defaultValue,
  }) async =>
      _varioqubApi.getInt(key: key, defaultValue: defaultValue);

  /// Getting the config value with the double type.
  static Future<double> getDouble({
    required final String key,
    required final double defaultValue,
  }) async =>
      _varioqubApi.getDouble(key: key, defaultValue: defaultValue);

  static Future<Set<String>> getAllKeys() async =>
      Set.from(await _varioqubApi.getAllKeys());

  static Future<Map<String, String>> getAllValues() async =>
      Map<String, String>.from(await _varioqubApi.getAllValues());
}

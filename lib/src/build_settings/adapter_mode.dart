/// {@template VarioqubAdapterMode}
/// Mode for selecting the adapter.
///
/// Allows to select the implementation of the adapter for analyzing
/// the work of configs and configuring the user for experiments.
/// {@endtemplate}
enum VarioqubAdapterMode {
  /// Using Appmetrica adapters from Varioqub/MetricaAdapter in IOS version
  /// and com.yandex.varioqub.appmetricaadapter.AppMetricaAdapter
  /// in android version.
  ///
  /// In this case, analytics about the use of experiments and configs
  /// is collected in Appmetrica.
  appmetrica,

  /// Using zero adapter
  ///
  /// In this case, analytics about the use
  /// of configs is not collected.
  /// The use of experiments is not considered possible,
  /// there is no way to identify the user.
  none;
}

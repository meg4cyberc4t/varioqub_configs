import 'package:flutter/widgets.dart';
import 'package:varioqub_configs/varioqub_configs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final varioqub = VarioqubConfigs();
  debugPrint('build varioqub');
  await varioqub.build(
    const BuildSettings(client: VarioqubClient.appmetrica('4519366')),
  );

  debugPrint('activating config');
  await varioqub.activateConfig();

  debugPrint('fetching config');
  await varioqub.fetchConfig();

  debugPrint('getting value');
  debugPrint(
    await varioqub.getString(
      key: 'FLAG',
      defaultValue: 'DEFAULT',
    ),
  );
}

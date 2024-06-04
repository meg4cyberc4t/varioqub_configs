import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:varioqub_configs/varioqub_configs.dart';

const String _appMetricaKey =
    'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX'; // Add your AppMetrica key here
const String _clientId = 'appmetrica.XXXXXXX'; // Add your application id here

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initializing AppMetrica (if you want to use config analytics)
  await AppMetrica.activate(const AppMetricaConfig(_appMetricaKey));

  // Initializing Varioqub
  await Varioqub.build(
    const VarioqubSettings(
      clientId: _clientId,
      // The use of this flag is mandatory after initialization of AppMetrica
      trackingWithAppMetrica: true, // (if you want to use config analytics)
    ),
  );

  // Activation of the last previously configured config.
  // If there were no fetches, the default values will be used.
  await Varioqub.activateConfig();

  // Getting the configuration from the server.
  // They may return different errors described in [VarioqubFetchError].
  try {
    await Varioqub.fetchConfig();
  } on VarioqubFetchException catch (exception) {
    if (exception.error == VarioqubFetchError.requestThrottled) {
      debugPrint('Request has been throttled');
    } else {
      rethrow;
    }
  }

  runApp(const MaterialApp(home: TestScreenWidget()));
}

class TestScreenWidget extends StatefulWidget {
  const TestScreenWidget({super.key});

  @override
  State<TestScreenWidget> createState() => TestScreenWidgetState();
}

class TestScreenWidgetState extends State<TestScreenWidget> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Press button to print config'),
        ),
        body: Center(
          child: CupertinoButton.filled(
            onPressed: () async {
              final value = await Varioqub.getString(
                key: 'EXAMPLE_FLAG',
                defaultValue: 'DEFAULT_VALUE',
              );
              debugPrint(value);
            },
            child: const Text('Get config'),
          ),
        ),
      );
}

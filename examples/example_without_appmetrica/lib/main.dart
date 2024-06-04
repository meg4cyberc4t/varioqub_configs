import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:varioqub_configs/varioqub_configs.dart';

const String _clientId = 'appmetrica.XXXXXXX'; // Add your application id here

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Varioqub.build(
    const VarioqubSettings(
      clientId: _clientId,
    ),
  );
  await Varioqub.activateConfig();

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

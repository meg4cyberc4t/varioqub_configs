// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:varioqub_configs/varioqub_configs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final varioqub = VarioqubConfigs();
  await varioqub.build(
    const BuildSettings(
      client: VarioqubClient.appmetrica(
        'XXXXXXX',
      ),
    ), //  your AppMetrica application ID
  );
  await varioqub.activateConfig();
  await varioqub.fetchConfig();

  runApp(
    MaterialApp(
      home: TestScreenWidget(
        varioqub: varioqub,
      ),
    ),
  );
}

class TestScreenWidget extends StatefulWidget {
  final VarioqubConfigs varioqub;

  const TestScreenWidget({
    required this.varioqub,
    super.key,
  });

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
              debugPrint(
                await widget.varioqub.getString(
                  key: 'FLAG',
                  defaultValue: 'DEFAULT',
                ),
              );
            },
            child: const Text('Get config'),
          ),
        ),
      );
}

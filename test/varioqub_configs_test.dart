// import 'package:flutter_test/flutter_test.dart';
// import 'package:varioqub_configs/varioqub_configs.dart';
// import 'package:varioqub_configs/varioqub_configs_platform_interface.dart';
// import 'package:varioqub_configs/varioqub_configs_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockVarioqubConfigsPlatform
//     with MockPlatformInterfaceMixin
//     implements VarioqubConfigsPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final VarioqubConfigsPlatform initialPlatform = VarioqubConfigsPlatform.instance;

//   test('$MethodChannelVarioqubConfigs is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelVarioqubConfigs>());
//   });

//   test('getPlatformVersion', () async {
//     VarioqubConfigs varioqubConfigsPlugin = VarioqubConfigs();
//     MockVarioqubConfigsPlatform fakePlatform = MockVarioqubConfigsPlatform();
//     VarioqubConfigsPlatform.instance = fakePlatform;

//     expect(await varioqubConfigsPlugin.getPlatformVersion(), '42');
//   });
// }

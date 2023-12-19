import 'package:flutter_test/flutter_test.dart';
import 'package:basic_platform_service/basic_platform_service.dart';
import 'package:basic_platform_service/basic_platform_service_platform_interface.dart';
import 'package:basic_platform_service/basic_platform_service_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBasicPlatformServicePlatform
    with MockPlatformInterfaceMixin
    implements BasicPlatformServicePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BasicPlatformServicePlatform initialPlatform = BasicPlatformServicePlatform.instance;

  test('$MethodChannelBasicPlatformService is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBasicPlatformService>());
  });

  test('getPlatformVersion', () async {
    BasicPlatformService basicPlatformServicePlugin = BasicPlatformService();
    MockBasicPlatformServicePlatform fakePlatform = MockBasicPlatformServicePlatform();
    BasicPlatformServicePlatform.instance = fakePlatform;

    expect(await basicPlatformServicePlugin.getPlatformVersion(), '42');
  });
}

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'basic_platform_service_platform_interface.dart';

/// An implementation of [BasicPlatformServicePlatform] that uses method channels.
class MethodChannelBasicPlatformService extends BasicPlatformServicePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('basic_platform_service');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}

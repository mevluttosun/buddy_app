import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'basic_platform_service_method_channel.dart';

abstract class BasicPlatformServicePlatform extends PlatformInterface {
  /// Constructs a BasicPlatformServicePlatform.
  BasicPlatformServicePlatform() : super(token: _token);

  static final Object _token = Object();

  static BasicPlatformServicePlatform _instance = MethodChannelBasicPlatformService();

  /// The default instance of [BasicPlatformServicePlatform] to use.
  ///
  /// Defaults to [MethodChannelBasicPlatformService].
  static BasicPlatformServicePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BasicPlatformServicePlatform] when
  /// they register themselves.
  static set instance(BasicPlatformServicePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

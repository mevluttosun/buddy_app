import 'basic_platform_service_platform_interface.dart';

class BasicPlatformService {
  Future<String?> getPlatformVersion() {
    return BasicPlatformServicePlatform.instance.getPlatformVersion();
  }
}

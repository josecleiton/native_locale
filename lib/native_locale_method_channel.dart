import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'native_locale_platform_interface.dart';

/// An implementation of [NativeLocalePlatform] that uses method channels.
class MethodChannelNativeLocale extends NativeLocalePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('native_locale');

  @override
  Future<void> setLocale(String locale) async {
    await methodChannel.invokeMethod<String>('setLocale');
  }
}

library native_locale;

import 'native_locale_platform_interface.dart';

export 'native_locale_platform_interface.dart';
export 'native_locale_method_channel.dart';

class NativeLocale {
  Future<void> setLocale(String locale) {
    return NativeLocalePlatform.instance.setLocale(locale);
  }

  Future<String?> getLocalized(String key) {
    return NativeLocalePlatform.instance.getLocalized(key);
  }

  Future<String> getLocale() => NativeLocalePlatform.instance.getLocale();
}

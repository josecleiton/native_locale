library native_locale;

import 'native_locale_platform_interface.dart';

class NativeLocale {
  Future<void> setLocale(String locale) {
    return NativeLocalePlatform.instance.setLocale(locale);
  }
}

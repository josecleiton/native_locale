import Flutter
import UIKit

public class NativeLocalePlugin: NSObject, FlutterPlugin, ActivityAware {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "native_locale", binaryMessenger: registrar.messenger())
    let instance = NativeLocalePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let arguments = call.arguments as? Dictionary<String, Any> else {
      result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
      return
    }

    switch call.method {
    case "setLocale":
      setLocale(arguments["locale"] as! String)
      result(true)
      exit(0)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func setLocale(_ locale: String) {
    let localeIdentifier = locale.replacingOccurrences(of: "_", with: "-")
    UserDefaults.standard.set([localeIdentifier], forKey: "AppleLanguages")
    UserDefaults.standard.synchronize()
  }
}

package com.example.native_locale

import android.app.Activity

import android.os.Build
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.*

/** NativeLocalePlugin */
class NativeLocalePlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel : MethodChannel
  private var activity : Activity? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "native_locale")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "setLocale") {
      setLocale(call.argument<String>("locale")!!)
      result.success(true)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }


  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
     activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  @Suppress("DEPRECATION")
  private fun setLocale(localeStr: String) {
    val activity = this.activity ?: return

    val resources = activity.resources
    val configuration = resources.configuration
    val displayMetrics = resources.displayMetrics
    val locale = Locale(localeStr)
      configuration.setLocale(locale)

    if (Build.VERSION.SDK_INT > Build.VERSION_CODES.N){
      activity.applicationContext.createConfigurationContext(configuration)
    } else {
      resources.updateConfiguration(configuration,displayMetrics)
    }
  }
}

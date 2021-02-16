package com.nh.addtoapp

import androidx.multidex.MultiDexApplication
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

/**
 * Created by Nagendra Hari Karthick K on 2/16/2021.
 */

const val ENGINE_ID = "1"

class App : MultiDexApplication() {
    var count = 0

    private lateinit var channel: MethodChannel

    override fun onCreate() {
        super.onCreate()

        val flutterEngine = FlutterEngine(this)
        flutterEngine
            .dartExecutor
            .executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
            )

        FlutterEngineCache.getInstance().put(ENGINE_ID, flutterEngine)

        channel = MethodChannel(flutterEngine.dartExecutor, "com.example/counter")

        channel.setMethodCallHandler { call, _ ->
            when (call.method) {
                "incrementCounter" -> {
                    count++
                    reportCounter()
                }
                "requestCounter" -> {
                    reportCounter()
                }
            }
        }
    }

    private fun reportCounter() {
        channel.invokeMethod("reportCounter", count)
    }
}

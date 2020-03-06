package dev.zaki50.flightlogbook

import android.content.Context

import androidx.multidex.MultiDex
import io.flutter.app.FlutterApplication

class MyApp: FlutterApplication() {
    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        MultiDex.install(this)
    }
}
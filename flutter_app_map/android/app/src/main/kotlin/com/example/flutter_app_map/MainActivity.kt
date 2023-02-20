package com.example.flutter_app_map

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setLocale("ru_RU") // Your preferred language. Not required, defaults to system language
        MapKitFactory.setApiKey("211d8318-499a-43b7-b0f0-ad1b97f9ed34") // Your generated API key
        super.configureFlutterEngine(flutterEngine)
    }
}

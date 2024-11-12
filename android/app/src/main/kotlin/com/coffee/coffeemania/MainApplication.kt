package com.coffee.coffeemania

import android.app.Application

import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setApiKey("1dbfc9dc-700d-4c7d-acd1-4cb4cd6117ae") // Your generated API key
    }
}
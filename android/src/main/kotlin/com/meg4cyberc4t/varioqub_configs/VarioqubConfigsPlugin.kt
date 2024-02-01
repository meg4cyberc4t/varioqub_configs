package com.meg4cyberc4t.varioqub_configs

import PigeonBuildSettings
import VarioqubSender
import android.content.Context
import android.util.Log
import com.yandex.varioqub.config.FetchError
import com.yandex.varioqub.config.OnFetchCompleteListener
import com.yandex.varioqub.config.Varioqub
import com.yandex.varioqub.config.VarioqubApi
import com.yandex.varioqub.config.VarioqubSettings

import io.flutter.embedding.engine.plugins.FlutterPlugin


/** VarioqubConfigsPlugin */
class VarioqubConfigsPlugin : FlutterPlugin, VarioqubSender {
    private companion object {
        private const val TAG = "VarioqubConfigsPlugin"
    }

    private lateinit var api: VarioqubApi
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        try {
            VarioqubSender.setUp(flutterPluginBinding.binaryMessenger, this)
            context = flutterPluginBinding.applicationContext
            api = Varioqub.getInstance()
        } catch (error: Throwable) {
            Log.e(TAG, "Failed to initialize TickerPlugin")
        }
    }


    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        VarioqubSender.setUp(binding.binaryMessenger, null)
        Varioqub.activateConfig()
    }

    override fun build(settings: PigeonBuildSettings) {
        var settingsBuilder =
            VarioqubSettings.Builder(settings.clientId)
                .withActivateEvent(settings.activateEvent)
        if (settings.logs == true) {
            settingsBuilder.withLogs().also { settingsBuilder = it };
        }
        settings.clientFeatures.forEach {
            if (it.key != null && it.value != null) {
                settingsBuilder = settingsBuilder.withClientFeature(it.key!!, it.value!!)
            }
        }
        api.init(
            settingsBuilder.build(),
            VarioqubAdapter(),
            context,
        );
    }

    override fun fetchConfig(callback: (Result<Unit>) -> Unit) {
        api.fetchConfig(
            object : OnFetchCompleteListener {
                override fun onSuccess() {
                    callback(Result.success(Unit))
                }

                override fun onError(message: String, error: FetchError) {
                    Log.e(TAG, message);
                    Log.e(TAG, error.toString());
                    callback(Result.failure(Throwable(message)))
                }
            }

        )
    }

    override fun activateConfig(callback: (Result<Unit>) -> Unit) {
        try {
            api.activateConfig(
                onComplete = {
                    callback(Result.success(Unit))
                }
            )
        } catch (exception: Throwable) {
            callback(Result.failure(exception))
        }
    }

    override fun setDefaults(values: Map<String, Any>) {
        return api.setDefaults(values);
    }

    override fun getString(key: String, defaultValue: String): String {
        return api.getString(key = key, default = defaultValue)
    }

    override fun getBool(key: String, defaultValue: Boolean): Boolean {
        return api.getBoolean(key = key, default = defaultValue)
    }

    override fun getInt(key: String, defaultValue: Long): Long {
        return api.getLong(key = key, default = defaultValue)
    }

    override fun getDouble(key: String, defaultValue: Double): Double {
        return api.getDouble(key = key, default = defaultValue)
    }

    override fun getId(): String {
        return api.getId()
    }

    override fun putClientFeature(key: String, value: String) {
        return api.putClientFeature(key = key, value = value)
    }

    override fun clearClientFeatures() {
        return api.clearClientFeatures()
    }

    override fun getAllKeys(): List<String> {
        return api.getAllKeys().toList();
    }
}

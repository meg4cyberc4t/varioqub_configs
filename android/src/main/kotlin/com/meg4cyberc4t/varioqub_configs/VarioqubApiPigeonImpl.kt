package com.meg4cyberc4t.varioqub_configs

import android.content.Context
import android.util.Log
import com.yandex.varioqub.config.*
import com.yandex.varioqub.appmetricaadapter.*


import io.flutter.embedding.engine.plugins.FlutterPlugin


class VarioqubApiPigeonImpl : FlutterPlugin, VarioqubApiPigeon {
    private companion object {
        private const val TAG = "VarioqubApiPigeonImpl"
    }

    private lateinit var varioqubApi: VarioqubApi
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        try {
            VarioqubApiPigeon.setUp(flutterPluginBinding.binaryMessenger, this)
            context = flutterPluginBinding.applicationContext
            varioqubApi = Varioqub.getInstance()
        } catch (error: Throwable) {
            Log.e(TAG, "Failed to initialize VarioqubApiPigeonImpl")
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        VarioqubApiPigeon.setUp(binding.binaryMessenger, null)
    }

    override fun build(settings: VarioqubSettingsPigeon) {
        var builder = VarioqubSettings.Builder(settings.clientId)
        if (settings.logs != null) {
            builder.withLogs().also { builder = it }
        }
        if (settings.activateEvent != null) {
            builder.withActivateEvent(settings.activateEvent).also { builder = it }
        }
        if (settings.url != null) {
            builder.withUrl(settings.url).also { builder = it }
        }
        if (settings.fetchThrottleIntervalMs != null) {
            Log.i(TAG, settings.fetchThrottleIntervalMs.toString())
            builder.withThrottleInterval(settings.fetchThrottleIntervalMs).also { builder = it }
        }
        settings.clientFeatures.forEach { (key, value) ->
            if (key == null || value == null) return
            builder.withClientFeature(key = key, value).also { builder = it }
        }

        varioqubApi.init(
            builder.build(),
            if(settings.trackingWithAppMetrica)  AppMetricaAdapter(context) else VarioqubNullAdapter(),
            context
        )
    }

    override fun fetchConfig(callback: (Result<FetchErrorPigeon?>) -> Unit) {
        varioqubApi.fetchConfig(
            object : OnFetchCompleteListener {
                override fun onSuccess() {
                    callback(Result.success(null))
                }
                override fun onError(message: String, error: FetchError) {
                    val fetchError: VarioqubFetchErrorPigeon = when (error) {
                        FetchError.INTERNAL_ERROR -> VarioqubFetchErrorPigeon.INTERNAL_ERROR
                        FetchError.EMPTY_RESULT -> VarioqubFetchErrorPigeon.EMPTY_RESULT
                        FetchError.IDENTIFIERS_NULL -> VarioqubFetchErrorPigeon.INTERNAL_ERROR
                        FetchError.RESPONSE_PARSE_ERROR -> VarioqubFetchErrorPigeon.RESPONSE_PARSE_ERROR
                        FetchError.REQUEST_THROTTLED -> VarioqubFetchErrorPigeon.REQUEST_THROTTLED
                        FetchError.NETWORK_ERROR -> VarioqubFetchErrorPigeon.NETWORK_ERROR
                    }
                    callback(
                        Result.success(
                            FetchErrorPigeon(
                                message = message,
                                error = fetchError
                            )
                        )
                    )
                }
            }
        )
    }

    override fun activateConfig(callback: (Result<Unit>) -> Unit) {
        try {
            varioqubApi.activateConfig(
                onComplete = {
                    callback(Result.success(Unit))
                }
            )
        } catch (exception: Throwable) {
            callback(Result.failure(exception))
        }
    }

    override fun setDefaults(values: Map<String, Any>) {
        return varioqubApi.setDefaults(values)
    }

    override fun getString(key: String, defaultValue: String): String {
        return varioqubApi.getString(key = key, default = defaultValue)
    }

    override fun getBool(key: String, defaultValue: Boolean): Boolean {
        return varioqubApi.getBoolean(key = key, default = defaultValue)
    }

    override fun getInt(key: String, defaultValue: Long): Long {
        return varioqubApi.getLong(key = key, default = defaultValue)
    }

    override fun getDouble(key: String, defaultValue: Double): Double {
        return varioqubApi.getDouble(key = key, default = defaultValue)
    }

    override fun getId(): String {
        return varioqubApi.getId()
    }

    override fun putClientFeature(key: String, value: String) {
        return varioqubApi.putClientFeature(key = key, value = value)
    }

    override fun clearClientFeatures() {
        return varioqubApi.clearClientFeatures()
    }

    override fun getAllKeys(): List<String> {
        return varioqubApi.getAllKeys().toList()
    }

    override fun getAllValues(): Map<String, String> {
        return varioqubApi.getAllKeys().associateWith { varioqubApi.getValue(it)!!.value!! }
    }
}

package com.meg4cyberc4t.varioqub_configs

import com.yandex.varioqub.analyticadapter.AdapterIdentifiersCallback
import com.yandex.varioqub.analyticadapter.VarioqubConfigAdapter

class VarioqubAdapter : VarioqubConfigAdapter {
    override val adapterName: String = "VarioqubAdapter"

    var deviceId: String = "000"
    var userId: String = "000"

    override fun reportConfigChanged(configData: com.yandex.varioqub.analyticadapter.data.ConfigData) {}

    override fun requestDeviceId(callback: AdapterIdentifiersCallback) {
        callback.onSuccess(deviceId)
    }

    override fun requestUserId(callback: AdapterIdentifiersCallback) {
        callback.onSuccess(userId)
    }

    override fun setExperiments(experiments: String) {}

    override fun setTriggeredTestIds(triggeredTestIds: Set<Long>) {}
}
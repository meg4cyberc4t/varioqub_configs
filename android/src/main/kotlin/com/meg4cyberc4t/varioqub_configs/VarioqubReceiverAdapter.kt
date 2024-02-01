package com.meg4cyberc4t.varioqub_configs

import com.yandex.varioqub.analyticadapter.AdapterIdentifiersCallback
import com.yandex.varioqub.analyticadapter.VarioqubConfigAdapter

class VarioqubAdapter : VarioqubConfigAdapter {
    override val adapterName: String = "VarioqubAdapter"

    override fun reportConfigChanged(configData: com.yandex.varioqub.analyticadapter.data.ConfigData) {}

    override fun requestDeviceId(callback: AdapterIdentifiersCallback) {
        callback.onSuccess("000")
    }

    override fun requestUserId(callback: AdapterIdentifiersCallback) {
        callback.onSuccess("000")
    }

    override fun setExperiments(experiments: String) {}

    override fun setTriggeredTestIds(triggeredTestIds: Set<Long>) {}
}
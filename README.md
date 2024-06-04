# Varioqub Configs

<img src="https://raw.githubusercontent.com/meg4cyberc4t/varioqub_configs/main/.github/images/vq_background.jpg" />

### Flutter plugin providing work with remote configs, experiments and A/B testing via <a href="https://varioqub.ru/">Varioqub</a>.

# Example of using

```dart
// Initializing Varioqub
await Varioqub.build(
    const VarioqubSettings(
      clientId: _clientId,
    ),
);

/// Activation of previous configs.
/// It is recommended to activate the configuration during application startup.
await Varioqub.activateConfig();

/// Extracting configs from Varioqub.
/// It is recommended to fetch the configuration during the application without waiting.
await Varioqub.fetchConfig();

/// Getting the config by "FLAG" key.
await Varioqub.getString(
    key: 'FLAG',
    defaultValue: 'DEFAULT_VALUE',
);
```

## Using together / without AppMetrica

Using the library together with AppMetrica is only available using the [appmetrica_plugin](https://pub.dev/packages/appmetrica_plugin) library version higher than 2.0.0.

To use experiments and analytics to get configs, use the following build configuration:

```dart
await AppMetrica.activate(const AppMetricaConfig(_appMetricaKey));

// Initializing Varioqub
await Varioqub.build(
    const VarioqubSettings(
        clientId: _clientId,
        // The use of this flag is mandatory after initialization of AppMetrica
        trackingWithAppMetrica: true,
    ),
);
```

## Request throttled exception

This exception, as well as other exceptions, can be received during `fetchConfig` execution. Expect them when getting the config as follows:

```dart
try {
    await Varioqub.fetchConfig();
} on VarioqubFetchException catch (exception) {
    if (exception.error == VarioqubFetchError.requestThrottled) {
        debugPrint('Request has been throttled');
    } else {
        rethrow;
    }
}
```

> Request throttled means that the timeout for the refetch request did not occur and the current request was canceled. If you want to change the fetch time, use `fetchThrottleIntervalMs` in `build` method.

# Sources

[What is Varioqub? (The main website of the Varioqub project)](https://varioqub.ru/)

[Official docs from Yandex](https://yandex.ru/support2/varioqub-app/ru/)

# Changelog

[Refer to the Changelog to get all release notes.](https://github.com/meg4cyberc4t/varioqub_configs/blob/main/CHANGELOG.md)

# Maintainers

[Igor Molchanov](https://github.com/meg4cyberc4t)

This library is open for issues and pull requests. If you have ideas for improvements or bugs, the repository is open to contributions!

# License

[MIT](https://opensource.org/license/mit/)

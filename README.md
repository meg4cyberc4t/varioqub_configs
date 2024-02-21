# Varioqub Configs

### Flutter plugin providing work with remote configs, experiments and A/B testing via <a href="https://varioqub.ru/">Varioqub</a>.

# Example of using

```dart
/// Initializing configs instance
final configs = VarioqubConfigs();
await configs.build(
    const BuildSettings(client: VarioqubClient.appmetrica('XXXXXXX')), // Your AppMetrica application ID
);

/// Activation of previous configs.
/// It is recommended to activate the configuration during application startup.
await configs.activateConfig();

/// Extracting configs from Varioqub.
/// It is recommended to fetch the configuration during the application without waiting.
await configs.fetchConfig();

/// Getting the config by "FLAG" key.
await configs.getString(
    key: 'FLAG',
    defaultValue: 'DEFAULT_VALUE',
);
```

# Sources

[What is Varioqub? (The main website of the Varioqub project)](https://varioqub.ru/)

[Official docs from Yandex](https://yandex.ru/support2/varioqub-app/ru/)

# Limitations

At the moment, the library is used exclusively for obtaining and working with configs and experiments. Analytics elements are not used for fetch!

# Changelog

[Refer to the Changelog to get all release notes.](https://github.com/meg4cyberc4t/varioqub_configs/blob/main/CHANGELOG.md)

# Maintainers

[Igor Molchanov](https://github.com/meg4cyberc4t)

This library is open for issues and pull requests. If you have ideas for improvements or bugs, the repository is open to contributions!

# License

[MIT](https://opensource.org/license/mit/)

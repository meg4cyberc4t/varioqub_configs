# Varioqub Configs

    Flutter plugin providing work with remote configs, experiments and A/B testing via Varioqub

# Example of using

```dart
final varioqub = VarioqubConfigs();

await varioqub.build(
    const BuildSettings(client: VarioqubClient.appmetrica('XXXXXXX')), //your AppMetrica application ID
);

await varioqub.activateConfig();

await varioqub.fetchConfig();

await varioqub.getString(
    key: 'FLAG',
    defaultValue: 'DEFAULT_VALUE',
);
```

# Sources
[What is Varioqub?](https://varioqub.ru/)

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
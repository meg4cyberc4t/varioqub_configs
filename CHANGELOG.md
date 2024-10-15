## 0.8.0

- **BREAKING CHANGES** API usage has switched to using static methods from the Varioqub class. Refer to the documentation and examples for migration. All methods remained the same.
- Varioqub versions for iOS have been updated to 7.1.0 accordingly.
- Added `getAllValues` method

## 0.7.1

- Removing the package tag in AndroidManifest.xml.

## 0.7.0

- Adding a VarioqubAdapter from native appmetrica implementations.
- **BREAKING CHANGES** getUserId, setUserId, getDeviceId, setDeviceId was deprecated and deleted. Use VarioqubAdapterMode adapterMode = VarioqubAdapterMode.appmetrica in VarioqubClient instead (By default when using appmetrica constructor).

## 0.6.2

- Downgrade of a minimum Dart version to 3.0.0.
- Updated docs.

## 0.6.1

- Added methods getUserId, updateUserId, getDeviceId, updateDeviceId for user analytics.
- Experiments for ios has been fixed.
- The Swift based version of Varioqub has been upgraded to 0.6.0 version.
- Updated docs.

## 0.6.0

- Pigeon have been updated to version ^17.0.0.
- Kotlin and swift packages have been updated to version 0.6.0.
- Updated docs.

## 0.0.3

- Changing dependencies in .podspec for ios projects, the library is now static

## 0.0.2

- Moving the lower sdk limits to >=3.2.0

## 0.0.1

- Initial release.

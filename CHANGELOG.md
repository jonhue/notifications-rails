# Changelog

This file tracks all unreleased breaking changes and deprecations on master. You can find a list of all releases [here](https://github.com/jonhue/notifications-rails/releases).

Notifications Rails follows Semantic Versioning 2.0 as defined at http://semver.org.

### Breaking Changes

* Creating notifications for groups is now done through `Notification.for_group` instead of passing `group` as an argument to `Notification.create`. [#108] (#110)

### Deprecated

* None

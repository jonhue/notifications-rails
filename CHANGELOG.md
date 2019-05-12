# Changelog

This file tracks all unreleased breaking changes and deprecations on master. You can find a list of all releases [here](https://github.com/jonhue/notifications-rails/releases).

Notifications Rails follows Semantic Versioning 2.0 as defined at http://semver.org.

### Breaking Changes

* Change Pusher/DeliveryMethod API to not push immediately when initialized. **Important**: If you have any custom
  pushers, you need to add a `call` method to it and *move* any code out of `initialize` (except
  code that is just doing initialization) and into the `call` method. [#49] (#55)

* Groups should now be defined using callables like `-> { where(subscriber: true) }`. [#44] (#84)

* `notification_subscribers`/`notification_subscribables` now return `Subscription` instances instead of actual subscribers/subscribables. [#70] (#87)

* Pushers/Delivery methods should now be in the `NotificationPusher::DeliveryMethod` namespace. [#58] (#88)

* Introduced a base class for pushers/delivery methods. Your custom pushers should now extend `NotificationPusher::DeliveryMethod::Base`. The class already implements the necessary initialization of instance vars. From your `call` method, you can access `notification` and `options`. [#58] (#88)

* Renamed the `define_pusher` configuration option to `register_delivery_method`. [#58] (#88)

* Renamed the `push` method to `deliver` and the pusher/delivery method attributes from `:pusher` to `:delivery_method` and from `:pusher_options` to `:delivery_options`. [#58] (#88)

### Deprecated

* None

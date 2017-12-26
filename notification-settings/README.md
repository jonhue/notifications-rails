# NotificationSettings

[![Gem Version](https://badge.fury.io/rb/notification-settings.svg)](https://badge.fury.io/rb/notification-settings) <img src="https://travis-ci.org/jonhue/notifications-rails.svg?branch=master" />

Integrates with your authentication solution to craft a personalized user notification platform.

---

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
    * [Categories](#categories)
    * [Subscriptions](#subscriptions)
    * [Status](#status)
    * [Pusher specific settings](#pusher-specific-settings)
    * [Device specific settings](#device-specific-settings)
    * [Updating settings](#updating-settings)
* [Configuration](#configuration)
    * [Status](#status)
* [To Do](#to-do)
* [Contributing](#contributing)
    * [Contributors](#contributors)
    * [Semantic versioning](#semantic-versioning)
* [License](#license)

---

## Installation

NotificationSettings works with Rails 5 onwards. You can add it to your `Gemfile` with:

```ruby
gem 'notification-settings'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install notification-settings

If you always want to be up to date fetch the latest from GitHub in your `Gemfile`:

```ruby
gem 'notification-settings', github: 'jonhue/notifications-rails/tree/master/notification-settings'
```

Now run the generator:

    $ rails g notification_settings:install

To wrap things up, migrate the changes to your database:

    $ rails db:migrate

---

## Usage

To add settings to a notification target add `notification_settings` to the class:

```ruby
class User < ApplicationRecord
    notification_target
    notification_settings
end
```

This will create a `NotificationSettings::Setting` record for every newly created object. It is accessible by calling:

```ruby
User.first.notification_setting
```

### Categories

...

### Subscriptions

...

### Status

NotificationSettings comes with a handy feature called Status. The status of a record can temporarily disable the ability to create notifications for or to push notifications of a target.

This is how to define a status:

```ruby
User.first.notification_setting.status = 'do not disturb'
User.first.notification_setting.save
```

**Note:** You can set `status` to any string you like.

`status` has three possible values that are being used as defaults. Normally it defaults to `'online'`. If the `last_seen` [configuration](#configuration) option has been set, it can also default to `'idle'` or `'offline'` depending on the `idle_after` and `offline_after` [configuration](#configuration) options.

If you have set `status` to a custom value, you can get back to using the defaults by setting it back to `nil`.

You can define statuses that prevent creating new notifications for a target and statuses that just prevent pushing them:

```ruby
NotificationSettings.configure do |config|
    config.do_not_notify_statuses = ['do not notify']
    config.do_not_push_statuses = ['do not disturb']
end
```

### Pusher specific settings

...

### Device specific settings

...

### Updating settings

...

---

## Configuration

You can configure NotificationSettings by passing a block to `configure`. This can be done in `config/initializers/notification-settings.rb`:

```ruby
NotificationSettings.configure do |config|
    config.idle_after = 10.minutes
end
```

### Status

**`idle_after`** Time duration without activity after which the status defaults to `'idle'`. Takes a time. Defaults to `10.minutes`.

**`offline_after`** Time duration without activity after which the status defaults to `'offline'`. Takes a time. Defaults to `3.hours`.

**`last_seen`** Stringified datetime attribute name of `object` that defines the time of the last activity. Takes a string. Defaults to `'last_seen'`.

**`do_not_notify_statuses`** Array of possible statuses that will prevent creating notifications for a target. Takes an array of strings. Defaults to `[]`.

**`do_not_push_statuses`** Array of possible statuses that will prevent pushing notifications of a target. Takes an array of strings. Defaults to `['do not disturb']`.

---

## To Do

[Here](https://github.com/jonhue/notifications-rails/projects/4) is the full list of current projects.

To propose your ideas, initiate the discussion by adding a [new issue](https://github.com/jonhue/notifications-rails/issues/new).

---

## Contributing

We hope that you will consider contributing to NotificationSettings. Please read this short overview for some information about how to get started:

[Learn more about contributing to this repository](https://github.com/jonhue/notifications-rails/blob/master/CONTRIBUTING.md), [Code of Conduct](https://github.com/jonhue/notifications-rails/blob/master/CODE_OF_CONDUCT.md)

### Contributors

Give the people some :heart: who are working on this project. See them all at:

https://github.com/jonhue/notifications-rails/graphs/contributors

### Semantic Versioning

NotificationSettings follows Semantic Versioning 2.0 as defined at http://semver.org.

## License

MIT License

Copyright (c) 2017 Jonas Hübotter

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

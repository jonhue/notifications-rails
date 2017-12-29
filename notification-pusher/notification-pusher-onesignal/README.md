# NotificationPusher for OneSignal

[![Gem Version](https://badge.fury.io/rb/notification-pusher-onesignal.svg)](https://badge.fury.io/rb/notification-pusher-onesignal) <img src="https://travis-ci.org/jonhue/notifications-rails.svg?branch=master" />

A pusher to send cross-platform notifications with OneSignal.

---

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
    * [Options](#options)
* [To Do](#to-do)
* [Contributing](#contributing)
    * [Contributors](#contributors)
    * [Semantic versioning](#semantic-versioning)
* [License](#license)

---

## Installation

NotificationPusher for OneSignal works with Rails 5 onwards. You can add it to your `Gemfile` with:

```ruby
gem 'notification-pusher-onesignal'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install notification-pusher-onesignal

If you always want to be up to date fetch the latest from GitHub in your `Gemfile`:

```ruby
gem 'notification-pusher-onesignal', github: 'jonhue/notifications-rails'
```

---

## Usage

Define this pusher in your `NotificationPusher` configuration:

```ruby
NotificationPusher.configure do |config|
    config.define_pusher :OneSignal, app_id: 'f158a844-9f3c-4207-b246-e93603b0a970', auth_key: 'kODc3N2ItOTNC00NGzOGYtMzI5OWQ3ZmQ'
end
```

Now you can push your notifications to OneSignal:

```ruby
notification = Notification.create target: User.first, object: Recipe.first
notification.push :OneSignal, player_ids: ['f158a844-9f3c-4207-b246-e93603b0a970'], url: Rails.application.routes.url_helpers.root_url, contents: {
    en: notification.object.title
}
```

To get player id's you could use the [devise-onesignal](https://github.com/jonhue/devise-onesignal) gem. This is how that would look:

```ruby
notification.push :OneSignal, player_ids: User.first.onesignal_player_ids
```

You can also store OneSignal information in your notification opposed to specifying it when pushing:

```ruby
notification.metadata[:onesignal_url] = Rails.application.routes.url_helpers.root_url
notification.metadata[:onesignal_contents] = { en: 'My notification content' }
notification.metadata[:onesignal_headers] = { en: 'My notification header' }
notification.metadata[:onesignal_subtitle] = { en: 'My notification subtitle' }
notification.save
notification.push :OneSignal, player_ids: User.first.onesignal_player_ids
```


### Options

**`app_id` (required)** OneSignal App ID. Takes a string.

**`auth_key` (required)** OneSignal API authentication key. Takes a string.

**`player_ids`** Array of OneSignal Player ID's a notification should be pushed to. Takes an array of strings.

**`url`** Specify a URL for this notification. Takes a string.

**`contents`** Globalized content of the notification. Takes a hash with languages as keys and strings as values.

**`headings`** Globalized header of the notification. Takes a hash with languages as keys and strings as values.

**`subtitle`** Globalized subtitle of the notification. Takes a hash with languages as keys and strings as values.

---

## To Do

[Here](https://github.com/jonhue/notifications-rails/projects/7) is the full list of current projects.

To propose your ideas, initiate the discussion by adding a [new issue](https://github.com/jonhue/notifications-rails/issues/new).

---

## Contributing

We hope that you will consider contributing to NotificationPusher for OneSignal. Please read this short overview for some information about how to get started:

[Learn more about contributing to this repository](https://github.com/jonhue/notifications-rails/blob/master/CONTRIBUTING.md), [Code of Conduct](https://github.com/jonhue/notifications-rails/blob/master/CODE_OF_CONDUCT.md)

### Contributors

Give the people some :heart: who are working on this project. See them all at:

https://github.com/jonhue/notifications-rails/graphs/contributors

### Semantic Versioning

NotificationPusher for OneSignal follows Semantic Versioning 2.0 as defined at http://semver.org.

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

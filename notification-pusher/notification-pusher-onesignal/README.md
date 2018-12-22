# NotificationPusher for OneSignal

[![Gem Version](https://badge.fury.io/rb/notifications-pusher-onesignal.svg)](https://badge.fury.io/rb/notifications-pusher-onesignal) ![Travis](https://travis-ci.org/jonhue/notifications-rails.svg?branch=master)

A pusher to send cross-platform notifications with OneSignal.

---

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
  * [Options](#options)
* [To Do](#to-do)
* [Contributing](#contributing)
  * [Semantic versioning](#semantic-versioning)

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
notification = Notification.create(target: User.first, object: Recipe.first)
notification.push(:OneSignal, player_ids: ['f158a844-9f3c-4207-b246-e93603b0a970'], url: Rails.application.routes.url_helpers.root_url, contents: {
  en: notification.object.title
})
```

To get player id's you could use the [devise-onesignal](https://github.com/jonhue/devise-onesignal) gem. This is how that would look:

```ruby
notification.push(:OneSignal, player_ids: notification.target.onesignal_player_ids)
```

You can also store OneSignal information in your notification opposed to specifying it when pushing:

```ruby
notification.metadata[:onesignal_url] = Rails.application.routes.url_helpers.root_url
notification.metadata[:onesignal_contents] = { en: 'My notification content' }
notification.metadata[:onesignal_headings] = { en: 'My notification header' }
notification.metadata[:onesignal_subtitle] = { en: 'My notification subtitle' }
notification.save
notification.push(:OneSignal, player_ids: notification.target.onesignal_player_ids)
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

We use [GitHub projects](https://github.com/jonhue/notifications-rails/projects/7) to coordinate the work on this project.

To propose your ideas, initiate the discussion by adding a [new issue](https://github.com/jonhue/notifications-rails/issues/new).

---

## Contributing

We hope that you will consider contributing to NotificationPusher for OneSignal. Please read this short overview for some information about how to get started:

[Learn more about contributing to this repository](https://github.com/jonhue/notifications-rails/blob/master/CONTRIBUTING.md), [Code of Conduct](https://github.com/jonhue/notifications-rails/blob/master/CODE_OF_CONDUCT.md)

### Semantic Versioning

NotificationPusher for OneSignal follows Semantic Versioning 2.0 as defined at http://semver.org.

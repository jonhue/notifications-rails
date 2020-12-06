# notification-pusher-onesignal

A delivery method to send your notifications to devices on all platforms with [notification-pusher](..) and OneSignal.

## Installation

You can add notification-pusher-onesignal to your `Gemfile` with:

```ruby
gem 'notification-pusher-onesignal'
```

And then run:

    $ bundle install

Or install it yourself as:

    $ gem install notification-pusher-onesignal

## Usage

Register this delivery method in your `NotificationPusher` configuration:

```ruby
NotificationPusher.configure do |config|
  config.register_delivery_method :one_signal, :OneSignal, app_id: 'f158a844-9f3c-4207-b246-e93603b0a970', auth_key: 'kODc3N2ItOTNC00NGzOGYtMzI5OWQ3ZmQ'
end
```

Now you can deliver your notifications through OneSignal:

```ruby
notification = Notification.create(target: User.first, object: Recipe.first)
notification.deliver(:one_signal, player_ids: ['f158a844-9f3c-4207-b246-e93603b0a970'], url: Rails.application.routes.url_helpers.root_url, contents: {
  en: notification.object.title
})
```

To get player id's you could use the [OnSignal](https://github.com/jonhue/onsignal-rails) gem. This is how that would look:

```ruby
notification.deliver(:one_signal, player_ids: notification.target.onesignal_player_ids)
```

You can also store OneSignal information in your notification opposed to specifying it when pushing:

```ruby
notification.metadata[:onesignal_url]      = Rails.application.routes.url_helpers.root_url
notification.metadata[:onesignal_contents] = { en: 'My notification content' }
notification.metadata[:onesignal_headings] = { en: 'My notification header' }
notification.metadata[:onesignal_subtitle] = { en: 'My notification subtitle' }
notification.save!
notification.deliver(:one_signal, player_ids: notification.target.onesignal_player_ids)
```

### Options

**`app_id` (required)** OneSignal App ID. Takes a string.

**`auth_key` (required)** OneSignal API authentication key. Takes a string.

**`player_ids`** Array of OneSignal Player ID's a notification should be pushed to. Takes an array of strings.

**`url`** Specify a URL for this notification. Takes a string.

**`contents`** Globalized content of the notification. Takes a hash with languages as keys and strings as values.

**`headings`** Globalized header of the notification. Takes a hash with languages as keys and strings as values.

**`subtitle`** Globalized subtitle of the notification. Takes a hash with languages as keys and strings as values.

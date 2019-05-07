# NotificationSettings

[![Gem Version](https://badge.fury.io/rb/notifications-settings.svg)](https://badge.fury.io/rb/notifications-settings) ![Travis](https://travis-ci.org/jonhue/notifications-rails.svg?branch=master)

Integrates with your authentication solution to craft a personalized user notification platform.

---

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
  * [Categories](#categories)
  * [Settings](#settings)
    * [Category-specific settings](#category-specific-settings)
    * [Pusher-specific settings](#pusher-specific-settings)
    * [Updating settings](#updating-settings)
  * [Subscriptions](#subscriptions)
  * [Status](#status)
* [Configuration](#configuration)
  * [Status](#status)
* [To Do](#to-do)
* [Contributing](#contributing)
  * [Semantic versioning](#semantic-versioning)

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
gem 'notification-settings', github: 'jonhue/notifications-rails'
```

Now run the generator:

    $ rails g notification_handler:install
    $ rails g notification_settings:install

To wrap things up, migrate the changes to your database:

    $ rails db:migrate

---

## Usage

NotificationSettings will create a `NotificationSettings::Setting` record for every newly created `notification_target`-object. It is accessible by calling:

```ruby
User.first.notification_setting
```

### Categories

NotificationSettings uses categories to allow your notification targets to define specific preferences. This is how you are able to specify the `category` of a `Notification` record:

```ruby
notification = Notification.create(target: User.first, object: Recipe.first, category: 'notification')
```

**Note:** The `category` attribute of any new `Notification` record will default to the [`default_category` configuration](#configuration).

You can also scope records by their category:

```ruby
# Return records with `'notification'` as category
Notification.notification_category

# Return records with `'follow'` as category
Notification.follow_category
```

### Settings

You can disable notifications for a given notification target:

```ruby
s = User.first.notification_setting
s.settings[:enabled] = false
```

This will prevent you from creating any new notifications with this user as target.

The default is `true` (enabled) for this setting and the other settings.

#### Category-specific settings

A user can also have category-specific settings:

```ruby
s.category_settings[:category] = { enabled: false }
```

#### Pusher-specific settings

He can have global or category-specific pusher settings:

```ruby
s.settings[:pusher_enabled] = false                       # Prevent pushing via *any* pusher
s.settings[:ActionMailer] = false                         # Prevent pushing via :ActionMailer pusher
s.category_settings[:category] = { ActionMailer: false }  # Prevent pushing via :ActionMailer pusher for :category
```

#### Updating settings

...

### Subscriptions

Subscriptions are a way to better handle settings for notifications from different objects to one notification target.

This is how to subscribe/unsubscribe a target to an object:

```ruby
User.first.subscribe(Recipe.first)
User.first.unsubscribe(Recipe.first)
```

Now you can easily notify all subscribers from the subscribable object:

```ruby
Recipe.first.notify_subscribers(push: :ActionMailer)
```

Let's assume that we have a group which has multiple chats. When sending notifications to subscribers of a given chat, we only want them to get notified. But when sending notifications about the group, we want to have everyone notified, that is either subscribed to the group or subscribed to one of its chats. To do that you have to add the `private` method `notification_dependents` to your model (in this case `Group`) and return an array of ActiveRecord objects whose subscribers should receive notifications for objects of this class.

```ruby
has_many :chats
has_many :talks

private

def notification_dependents
  self.chats
end
```

It is possible to override that behavior when notifying subscribers:

```ruby
# Disable notification dependents
Group.first.notify_subscribers(dependents: nil)

# Override notification dependents
Group.first.notify_subscribers(dependents: Group.first.chats + Group.first.talks)
```

You can customize settings for a single subscription just as you would for a notification target:

```ruby
s = User.first.notification_subscriptions.first.notification_setting
s.settings[:enabled] = false
```

[Learn more](#settings)

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

---

## Configuration

You can configure NotificationSettings by passing a block to `configure`. This can be done in `config/initializers/notification-settings.rb`:

```ruby
NotificationSettings.configure do |config|
  config.default_category = 'notification'
end
```

**`default_category`** Choose your default notification category. Takes a string. Defaults to `'notification'`.

### Status

**`idle_after`** Time duration without activity after which the status defaults to `'idle'`. Takes a time. Defaults to `10.minutes`.

**`offline_after`** Time duration without activity after which the status defaults to `'offline'`. Takes a time. Defaults to `3.hours`.

**`last_seen`** Stringified datetime attribute name of `object` that defines the time of the last activity. Takes a string. Defaults to `'last_seen'`.

**`do_not_notify_statuses`** Array of possible statuses that will prevent creating notifications for a target. Takes an array of strings. Defaults to `[]`.

**`do_not_push_statuses`** Array of possible statuses that will prevent pushing notifications of a target. Takes an array of strings. Defaults to `['do not disturb']`

---

## To Do

We use [GitHub projects](https://github.com/jonhue/notifications-rails/projects/4) to coordinate the work on this project.

To propose your ideas, initiate the discussion by adding a [new issue](https://github.com/jonhue/notifications-rails/issues/new).

---

## Contributing

We hope that you will consider contributing to NotificationSettings. Please read this short overview for some information about how to get started:

[Learn more about contributing to this repository](https://github.com/jonhue/notifications-rails/blob/master/CONTRIBUTING.md), [Code of Conduct](https://github.com/jonhue/notifications-rails/blob/master/CODE_OF_CONDUCT.md)

### Semantic Versioning

NotificationSettings follows Semantic Versioning 2.0 as defined at http://semver.org.

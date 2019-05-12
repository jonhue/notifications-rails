# NotificationPusher for ActionMailer

[![Gem Version](https://badge.fury.io/rb/notification-pusher-actionmailer.svg)](https://badge.fury.io/rb/notification-pusher-actionmailer) ![Travis](https://travis-ci.org/jonhue/notifications-rails.svg?branch=master)

A pusher to send your notifications via email utilizing ActionMailer.

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

NotificationPusher for ActionMailer works with Rails 5 onwards. You can add it to your `Gemfile` with:

```ruby
gem 'notification-pusher-actionmailer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install notification-pusher-actionmailer

---

## Usage

Register this pusher in your `NotificationPusher` configuration:

```ruby
NotificationPusher.configure do |config|
  config.register_delivery_method :ActionMailer
end
```

You can pass a `from` parameter, which will override the default email address specified in `ApplicationMailer`:

```ruby
NotificationPusher.configure do |config|
  config.register_delivery_method :ActionMailer, from: 'my@email.com'
end
```

Then add a renderer called `_actionmailer.html.erb` to every notification type you aim to support. Learn more [here](https://github.com/jonhue/notifications-rails/tree/master/notification-renderer).

Now you can deliver your notifications:

```ruby
notification = Notification.create(target: User.first, object: Recipe.first)
notification.deliver(:ActionMailer, to: 'another@email.com')
```

**Note:** If the email address, you want to deliver to, is the same as `notification.target.email` you can omit the `to` parameter.

It is also possible to override the email address sending this notification, by passing a `from` parameter.

### Options

**`to`** Receiver email address. Takes a string.

**`from`** Sender email address. Takes a string. Defaults to email specified in `ApplicationMailer`.

**`renderer`** Specify a renderer. Takes a string. Defaults to `'actionmailer'`.

**`layout`** Layout used for template rendering. Takes a string. Defaults to layout specified in `ApplicationMailer`.

---

## To Do

We use [GitHub projects](https://github.com/jonhue/notifications-rails/projects/6) to coordinate the work on this project.

To propose your ideas, initiate the discussion by adding a [new issue](https://github.com/jonhue/notifications-rails/issues/new).

---

## Contributing

We hope that you will consider contributing to NotificationPusher for ActionMailer. Please read this short overview for some information about how to get started:

[Learn more about contributing to this repository](https://github.com/jonhue/notifications-rails/blob/master/CONTRIBUTING.md), [Code of Conduct](https://github.com/jonhue/notifications-rails/blob/master/CODE_OF_CONDUCT.md)

### Semantic Versioning

NotificationPusher for ActionMailer follows Semantic Versioning 2.0 as defined at http://semver.org.

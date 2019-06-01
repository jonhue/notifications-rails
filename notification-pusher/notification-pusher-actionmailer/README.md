# NotificationPusher for ActionMailer

[![Gem Version](https://badge.fury.io/rb/notification-pusher-actionmailer.svg)](https://badge.fury.io/rb/notification-pusher-actionmailer) ![Travis](https://travis-ci.com/jonhue/notifications-rails.svg?branch=master)

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
  config.register_delivery_method :email, :ActionMailer
end
```

You can pass a `from` parameter, which will be used if you don't provide a `from` address when delivering:

```ruby
NotificationPusher.configure do |config|
  config.register_delivery_method :email, :ActionMailer, from: 'my@email.com'
end
```

Then add a renderer called `_actionmailer.html.erb` to every notification type you aim to support. Learn more [here](https://github.com/jonhue/notifications-rails/tree/master/notification-renderer).

Now you can deliver your notifications:

```ruby
require 'notification-renderer'

notification = Notification.create(target: User.first, object: Recipe.first)
notification.deliver(:email, to: 'another@email.com')
```

**Note:** If the email address, you want to deliver to, is the same as `notification.target.email` you can omit the `to` parameter.

It is also possible to override the email address sending this notification, by passing a `from` parameter.

If you don't want to use [NotificationRenderer](https://github.com/jonhue/notifications-rails/tree/master/notification-renderer):

```ruby
notification = Notification.create(target: User.first, object: Recipe.first)
notification.deliver(:email, to: 'another@email.com', mailer: MyCustomMailer, action: :deliver_notification)
```

`MyCustomMailer.deliver_notification` is then called with a `notification` as first argument and an options hash as second argument.

### Options

**`to`** Receiver email address. Takes a string.

**`from`** Sender email address. Takes a string.

**`renderer`** Specify a renderer. Takes a string. Defaults to `'actionmailer'`.

**`layout`** Layout used for template rendering. Takes a string. Defaults to layout specified in `ApplicationMailer`.

**`mail_options`** A hash that is passed to `mail` (e.g. including `:subject`). Takes a hash. Defaults to `{}`.

**`mailer`** ActionMailer class. Takes a constant. Defaults to `NotificationPusher::ActionMailer::NotificationMailer`.

**`action`** ActionMailer action. Takes a symbol. Defaults to `:push`.

**`deliver_method`** ActionMailer deliver_method (e.g. `:deliver_later`). Takes a symbol. Defaults to `:deliver`.

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

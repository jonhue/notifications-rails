# NotificationPusher

[![Gem Version](https://badge.fury.io/rb/notification-pusher.svg)](https://badge.fury.io/rb/notification-pusher) ![Travis](https://travis-ci.org/jonhue/notifications-rails.svg?branch=master)

Deliver your notifications through various services. Including Email delivery & OneSignal (cross-platform notification delivery).

---

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
  * [Delivery methods](#delivery-methods)
    * [Defining a delivery method](#defining-a-delivery-method)
    * [Using a delivery method](#using-a-delivery-method)
  * [Writing a custom delivery method](#writing-a-custom-delivery-method)
* [To Do](#to-do)
* [Contributing](#contributing)
  * [Semantic versioning](#semantic-versioning)

---

## Installation

NotificationPusher works with Rails 5 onwards. You can add it to your `Gemfile` with:

```ruby
gem 'notification-pusher'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install notification-pusher

Now run the generator:

    $ rails g notification_pusher:install

To wrap things up, migrate the changes to your database:

    $ rails db:migrate

---

## Usage

### Delivery methods

A delivery method handles the process of sending your notifications to various services for you.

#### Defining a delivery method

You register delivery methods in your `NotificationPusher` configuration (`config/initializers/notification-pusher.rb`). Using:

```ruby
NotificationPusher.configure do |config|
  config.register_delivery_method name, options
end
```

More details about defining a specific delivery method (name and available options) are available in the respective documentation of the gem.

#### Using a delivery method

It is super simple to initialize a delivery:

```ruby
notification = Notification.create(target: User.first, object: Recipe.first)
notification.deliver(name, custom_options)
```

Where `name` is the name of the defined delivery method and `custom_options` are the options that will override the default options the delivery method has been defined with.

You are also able to do the exact same in just one line of code:

```ruby
notification = Notification.create(target: User.first, object: Recipe.first, delivery_method: name, delivery_options: custom_options)
```

**Note:** In this case, pass `custom_options` as a `Hash`.

It is possible to use mutliple delivery methods at a time:

```ruby
notification.deliver([name_one, name_two], name_one: custom_options, name_two: custom_options)
```

### Writing a custom delivery method

Writing custom delivery methods is fairly simple. Just add a new class to the `NotificationPusher::DeliveryMethod` namespace:

```ruby
module NotificationPusher
  module DeliveryMethod
    class CustomPusher < NotificationPusher::DeliveryMethod::Base
      def call
        # `notification` and `options` are accessible here
      end
    end
  end
end
```

This is how to register and use your delivery method:

```ruby
NotificationPusher.configure do |config|
  config.register_delivery_method :CustomPusher, option_one: 'value_one'
end
```

```ruby
notification = Notification.create(target: User.first, object: Recipe.first)
notification.deliver(:CustomPusher, option_one: 'value_two')
```

For further reference take a look at the default [ActionMailer](notification-pusher-actionmailer) and [OneSignal](notification-pusher-onesignal) delivery methods.

---

## To Do

We use [GitHub projects](https://github.com/jonhue/notifications-rails/projects/3) to coordinate the work on this project.

To propose your ideas, initiate the discussion by adding a [new issue](https://github.com/jonhue/notifications-rails/issues/new).

---

## Contributing

We hope that you will consider contributing to NotificationPusher. Please read this short overview for some information about how to get started:

[Learn more about contributing to this repository](https://github.com/jonhue/notifications-rails/blob/master/CONTRIBUTING.md), [Code of Conduct](https://github.com/jonhue/notifications-rails/blob/master/CODE_OF_CONDUCT.md)

### Semantic Versioning

NotificationPusher follows Semantic Versioning 2.0 as defined at http://semver.org.

# NotificationPusher

[![Gem Version](https://badge.fury.io/rb/notification-pusher.svg)](https://badge.fury.io/rb/notification-pusher) ![Travis](https://travis-ci.org/jonhue/notifications-rails.svg?branch=master)

Push your notifications to various services. Including Email & OneSignal (cross-platform notifications).

---

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
  * [Pushers](#pushers)
    * [Defining a pusher](#defining-a-pusher)
    * [Using a pusher](#using-a-pusher)
  * [Writing a custom pusher](#writing-a-custom-pusher)
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

If you always want to be up to date fetch the latest from GitHub in your `Gemfile`:

```ruby
gem 'notification-pusher', github: 'jonhue/notifications-rails'
```

Now run the generator:

    $ rails g notification_pusher:install

To wrap things up, migrate the changes to your database:

    $ rails db:migrate

---

## Usage

### Pushers

A pusher handles the process of sending your notifications to various services for you.

#### Defining a pusher

You define pushers in your `NotificationPusher` configuration (`config/initializers/notification-pusher.rb`). Using:

```ruby
NotificationPusher.configure do |config|
  config.define_pusher name, options
end
```

More details about defining a specific pusher (name and available options) are available in the respective documentation of the gem.

#### Using a pusher

It is super simple to initialize a push:

```ruby
notification = Notification.create(target: User.first, object: Recipe.first)
notification.push(name, custom_options)
```

Where `name` is the name of the defined pusher and `custom_options` are the options that will override the default options the pusher has been defined with.

You are also able to do the exact same in just one line of code:

```ruby
notification = Notification.create(target: User.first, object: Recipe.first, pusher: name, pusher_options: custom_options)
```

**Note:** In this case, pass `custom_options` as a `Hash`.

It is possible to use mutliple pushers at a time:

```ruby
notification.push([name_one, name_two], name_one: custom_options, name_two: custom_options)
```

### Writing a custom pusher

Writing custom pushers is fairly simple. Just add a new subclass to `NotificationPusher`:

```ruby
class NotificationPusher::CustomPusher
  def initialize(notification, options = {})
    # ...
  end
end
```

This is how to define and use your pusher:

```ruby
NotificationPusher.configure do |config|
  config.define_pusher :CustomPusher, option_one: 'value_one'
end
```

```ruby
notification = Notification.create(target: User.first, object: Recipe.first)
notification.push(:CustomPusher, option_one: 'value_two')
```

For further reference take a look at the default [ActionMailer](notification-pusher-actionmailer) and [OneSignal](notification-pusher-onesignal) pushers.

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

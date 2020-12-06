# notification-pusher

Deliver your notifications to various services, including [Email](notification-pusher-actionmailer) and [OneSignal](notification-pusher-onesignal).

## Installation

You can add notification-pusher to your `Gemfile` with:

```ruby
gem 'notification-pusher'
```

And then run:

    $ bundle install

Or install it yourself as:

    $ gem install notification-pusher

Now run the generator:

    $ rails g notification_pusher:install

To wrap things up, migrate the changes to your database:

    $ rails db:migrate

## Usage

### Delivery methods

A delivery method handles the process of sending your notifications to various services for you.

#### Defining a delivery method

You register delivery methods in your `NotificationPusher` configuration (`config/initializers/notification-pusher.rb`). Using:

```ruby
NotificationPusher.configure do |config|
  config.register_delivery_method name, class_name, options
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
  config.register_delivery_method :custom, :CustomPusher, option_one: 'value_one'
end
```

```ruby
notification = Notification.create(target: User.first, object: Recipe.first)
notification.deliver(:custom, option_one: 'value_two')
```

For further reference take a look at the default [ActionMailer](notification-pusher-actionmailer) and [OneSignal](notification-pusher-onesignal) delivery methods.

# notification-settings

Integrates with your authentication solution to craft a personalized user notification platform.

## Installation

You can add notification-settings to your `Gemfile` with:

```ruby
gem 'notification-settings'
```

And then run:

    $ bundle install

Or install it yourself as:

    $ gem install notification-settings

Now run the generator:

    $ rails g notification_handler:install
    $ rails g notification_settings:install

To wrap things up, migrate the changes to your database:

    $ rails db:migrate

## Usage

First, you have to add some attributes to every model that acts as a `notification_target`:

```ruby
class User
  # ...

  notification_target
end
```

```ruby
# A Hashie::Mash object that stores all the settings of a notification target.
add_column :users, :settings, :text

# A string that describes a notification-relevant state of a notification target.
add_column :users, :status, :string
```

### Categories

notification-settings uses categories to allow your notification targets to define specific preferences. This is how you are able to specify the `category` of a `Notification` record:

```ruby
notification = Notification.create(target: User.first, object: Recipe.first, category: :notification)
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

You can completely disable notifications for a given notification target:

```ruby
settings = User.first.settings

settings.enabled = false
```

This will prevent you from creating any new notifications with this user as target.

The default is `true` (enabled) for this setting and the other settings.

#### Category-specific settings

A user can also have category-specific settings:

```ruby
settings.categories!.send("#{category}!").enabled = false
```

#### Delivery-method-specific settings

He can have global or category-specific delivery method settings:

```ruby
settings.delivery_methods!.enabled = false                              # Prevent delivering via *any* delivery method
settings.delivery_methods!.email!.enabled = false                       # Prevent delivering via the :email delivery method
settings.categories!.category!.delivery_methods!.email!.enabled = false # Prevent delivering via the :email delivery method for :category
```

#### Form objects

notification-settings comes with three form objects that simplify building forms for updating settings.

##### PreferencesForm

The preferences form has just one attribute: `enabled`. It can be used to update the global notification setting.

```ruby
user = User.first

form = NotificationSettings::PreferencesForm.new(enabled: user.settings.enabled)
form.valid?

user.settings.enabled = form.enabled
```

##### CategoryPreferencesForm

The category preferences form has one attribute per category. It can be used to update category-specific settings.

```ruby
user = User.first

form = NotificationSettings::CategoryPreferencesForm.new(user.settings.categories_.to_h)
form.valid?

form.changed_attributes.each do |category|
  user.settings.categories!.send(category, form.send(category))
end
```

##### DeliveryMethodPreferencesForm

The delivery method preferences form has one attribute per category and a general `enabled` attribute. It can be used to update delivery-method-specific settings or to disable all delivery methods.

```ruby
user = User.first

form = NotificationSettings::DeliveryMethodPreferencesForm.new(user.settings.delivery_methods_.to_h)
form.valid?

form.changed_attributes.each do |delivery_method|
  user.settings.delivery_methods!.send(delivery_method, form.send(delivery_method))
end
```

### Subscriptions

Subscriptions are a way to better handle settings for notifications from different objects to one notification target.

This is how to subscribe/unsubscribe a target to an object:

```ruby
User.first.subscribe(Recipe.first)
User.first.unsubscribe(Recipe.first)
```

Now you can easily notify all subscribers from the subscribable object:

```ruby
Recipe.first.notify_subscribers(delivery_method: :ActionMailer)
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

You can customize settings & status for a single subscription just as you would for a notification target:

```ruby
user = User.first
subscription = user.notification_subscriptions.first

subscription.settings.enabled = false
subscription.status = 'online'
subscription.save
```

[Learn more](#settings)

You can add associations to your subscriber/subscribable classes if you need easy access to all their subscriptions:

```ruby
# For subscribers:
# List all subscriptions of a subscriber
subscriber.notification_subscribables
# List all subscribables of a specific type a subscriber subscribed to
has_many :subscribed_products, through: :notification_subscribables, source: :subscribable, source_type: 'Product'

# For subscribables:
# List all subscriptions of a subscriber
subscribable.notification_subscribers
# List all subscribers of a specific type that subscribed to a subscribable
has_many :subscribed_users, through: :notification_subscribers, source: :subscriber, source_type: 'User'
```

### Status

notification-settings comes with a handy feature called Status. The status of a record can temporarily disable the ability to create notifications for or to push notifications of a target.

This is how to define a status:

```ruby
User.first.update(status: 'do not disturb')
```

**Note:** You can set `status` to any string you like.

`status` has three possible values that are being used as defaults. Normally it defaults to `'online'`. If the `last_seen` [configuration](#configuration) option has been set, it can also default to `'idle'` or `'offline'` depending on the `idle_after` and `offline_after` [configuration](#configuration) options.

If you have set `status` to a custom value, you can get back to using the defaults by setting it back to `nil`.

You can define statuses that prevent creating new notifications for a target and statuses that just prevent delivering them:

```ruby
NotificationSettings.configure do |config|
  config.do_not_notify_statuses  = ['do not notify']
  config.do_not_deliver_statuses = ['do not disturb']
end
```

## Configuration

You can configure notification-settings by passing a block to `configure`. This can be done in `config/initializers/notification-settings.rb`:

```ruby
NotificationSettings.configure do |config|
  config.categories = [:notification]
end
```

**`categories`** Choose your default notification category. Takes an array of symbols. Defaults to `[:notification]`.

**`default_category`** Choose your default notification category. Takes a symbol. Defaults to `:notification`.

### Status

**`idle_after`** Time duration without activity after which the status defaults to `'idle'`. Takes a time. Defaults to `10.minutes`.

**`offline_after`** Time duration without activity after which the status defaults to `'offline'`. Takes a time. Defaults to `3.hours`.

**`last_seen`** Stringified datetime attribute name of `object` that defines the time of the last activity. Takes a symbol. Defaults to `:last_seen`.

**`statuses`** Array of all possible statuses. Takes an array of strings. Defaults to `['online', 'idle', 'offline', 'do not notify', 'do not disturb']`.

**`do_not_notify_statuses`** Array of possible statuses that will prevent creating notifications for a target. Takes an array of strings. Defaults to `['do not notify']`.

**`do_not_deliver_statuses`** Array of possible statuses that will prevent delivering notifications of a target. Takes an array of strings. Defaults to `['do not disturb']`

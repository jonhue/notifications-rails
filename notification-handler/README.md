# notification-handler

Create and modify your notifications through a simple API.

## Installation

You can add notification-handler to your `Gemfile` with:

```ruby
gem 'notification-handler'
```

And then run:

    $ bundle install

Or install it yourself as:

    $ gem install notification-handler

Now run the generator:

    $ rails g notification_handler:install

To wrap things up, migrate the changes to your database:

    $ rails db:migrate

## Usage

### `Notification` API

You can use all the ActiveRecord methods you know and love on your `Notification` class. So creating a new notification is dead simple:

```ruby
notification = Notification.new
```

Every `Notification` object has a `target` record. This target record is the object, that this notification belongs to (or targets). Usually it's a user, but it can be a record of any class:

```ruby
notification.target = User.first
```

To store information in your `Notification` record you can use the `metadata` attribute that gets serialized as a `Hash`:

```ruby
notification.metadata = {
  title: 'My first notification',
  content: "It looks great, doesn't it?"
}
```

Another form of adding information is by associating an object to the notification. This can be a record of any class you like:

```ruby
notification.object = Recipe.first
```

The `read` attribute determines whether a notification has been seen or not:

```ruby
notification.read = true
notification.read? # true
notification.unread? # false
```

You can use scopes to filter for read or unread notifications:

```ruby
# Return all read notifications
Notification.read

# Return all unread notifications
Notification.unread

# Number of unread notifications
Notification.unread.size
```

### `notification_target`

To use records of an ActiveRecord class as notification targets, add the following to your class:

```ruby
class User < ApplicationRecord
  notification_target
end
```

Now belonging notifications are easy to access:

```ruby
notifications = User.first.notifications
```

You can create a notification from a `target`:

```ruby
User.first.notify(object: Recipe.first)
```

### `notification_object`

When using records of an ActiveRecord class as notification objects, add this to your class:

```ruby
class Recipe < ApplicationRecord
  notification_object
end
```

Now associated notifications are easy to access:

```ruby
notifications = Recipe.first.belonging_notifications
```

### Groups

Groups are a powerful way to bulk-create notifications for multiple objects that don't necessarily have a common class.

#### Defining a group

You define groups in your `NotificationHandler` configuration:

```ruby
NotificationHandler.configure do |config|
  config.define_group :subscribers, -> { User.where(subscriber: true) }
end
```

When creating a notification for the group `:subscribers`, one notification will be added for every target that fulfills this scope: `User.where(subscriber: true)`. You can also target objects from different classes:

```ruby
NotificationHandler.configure do |config|
  config.define_group :subscribers,     -> { User.where(subscriber: true) + Admin.all }
  config.define_group :company_members, lambda { |company_id|
    User.with_role(:member, Company.find(company_id)
  }
end
```

The only requirement is that the result of evaluating the proc be Enumerable.

#### Using a group

Bulk-creation of notifications for a certain group is fairly simple:

```ruby
notifications = Notification.for_group(:subscribers, attrs: { object: Recipe.first })
notifications = Notification.for_group(:company_members, args: [4], attrs: { object: Recipe.first })
```

`Notification.for_group` returns an array of `Notification` objects.

**Note:** You are not able to set the `target` attribute when a `group` has been specified.

### Caching

You can cache the amount of unread and read notifications for notification targets by settings the [`cache`](#configuration) configuration option to `true`.

Then add the following columns to the database tables of ActiveRecord classes acting as notification targets:

```ruby
add_column :user, :read_notification_count, :integer
add_column :user, :unread_notification_count, :integer
```

## Configuration

You can configure notification-handler by passing a block to `configure`. This can be done in `config/initializers/notification-handler.rb`:

```ruby
NotificationHandler.configure do |config|
  config.cache = true
end
```

**`cache`** Cache amount of unread and read notifications for notification targets. Takes a boolean. Defaults to `false`.

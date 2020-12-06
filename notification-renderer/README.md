# notification-renderer

Render your notifications in various contexts.

## Installation

You can add notification-renderer to your `Gemfile` with:

```ruby
gem 'notification-renderer'
```

And then run:

    $ bundle install

Or install it yourself as:

    $ gem install notification-renderer

Now run the generator:

    $ rails g notification_renderer:install

To wrap things up, migrate the changes to your database:

    $ rails db:migrate

## Usage

### Types

notification-renderer uses templates to render your notifications.

The `type` of a notification determines which template gets utilized for rendering. Each notification type has multiple templates each of which responsible for rendering a notification in another scenario. The default template for a given type is `index`.

#### Generating a new type

This gem comes with a generator to make adding new types a whole lot easier. Run in your terminal:

    $ rails g notification_renderer:type -t notification

This will create the following structure in your application:

* `views`
  * `notifications`
    * `notification`
      * `_index.html.erb`

You can also customize the generated templates (renderers):

    $ rails g notification_renderer:type -t notification -r index feed

This command will also create a custom renderer called `feed` for the notification type `notification`:

* `views`
  * `notifications`
    * `notification`
      * `_feed.html.erb`
      * `_index.html.erb`

#### Using a type

You are able to specify the `type` of a `Notification` record:

```ruby
notification = Notification.create(target: User.first, object: Recipe.first, type: 'notification')
```

**Note:** The `type` attribute of any new `Notification` record will default to the [`default_type` configuration](#configuration).

You can also scope records by their type:

```ruby
# Return records with `'notification'` as type
Notification.notification_type

# Return records with `'follow'` as type
Notification.follow_type
```

### Renderers

In your renderers you can access the `Notification` record through the `notification` variable. This is how a renderer could look like:

```erb
<%= notification.target.name %> commented on <%= notification.object.article.title %>.
```

### View helpers

notification-renderer introduces some view helpers to assist you in embedding notifications.

#### `render_notification`

`render_notification` renders a single `Notification` record:

```erb
<%= render_notification Notification.first %>
```

Rendering a notification will set its `read` attribute to `true`. This behavior can be [configured](#configuration).

You can also specify a renderer. It defaults to `'index'`.

```erb
<%= render_notification Notification.first, 'feed' %>
```

#### `render_notifications`

`render_notifications` takes an ActiveRecord array of `Notification` records and renders each of them in order:

```erb
<%= render_notifications Notification.all %>
```

You can also specify a renderer. It defaults to `'index'`.

```erb
<%= render_notifications Notification.all, 'feed' %>
```

It wraps the rendered notifications in a `div`:

```html
<div class="notification-renderer notifications">
  <!-- ... -->
</div>
```

### Grouping

You can group any ActiveRecord array of `Notification` records by an attribute value:

```ruby
Notification.all.grouping(['object.article'])
Notification.all.grouping(['object.article', 'metadata[:title]'])
```

**Note:** Notifications will be grouped in order.

When rendering notifications you often want to group them by the object they belong to. This is how to group notifications by the associated object:

```erb
<%= render_notifications_grouped Notification.all, ['object'], renderer: 'feed' %>
```

You can also group notifications by nested attributes:

```erb
<%= render_notifications_grouped Notification.all, ['object.article'] %>
<%= render_notifications_grouped Notification.all, ['metadata[:title]'] %>
```

It is also possible to group notifications for just one object:

```erb
<%= render_notifications_grouped Notification.where(object_id: 1, object_type: 'Comment'), ['object'] %>
```

This will render the last notification for every group and pass the attributes value grouped by to your renderer:

```erb
<!-- View -->

<%= render_notifications_grouped Notification.notification_type, ['object.article'] %>
```

```erb
<!-- Renderer -->

<% if notification_grouped? %>
  <%= notification.target.name %> and <%= (notifications.size - 1).to_s %> others commented on <%= attributes['object.article'].title %>.
<% else %>
  <%= notification.target.name %> commented on <%= notification.object.article.title %>.
<% end %>
```

Grouping makes the following two methods available in your renderer:

**`attributes`** Hash of attributes grouped by and their values.

**`notifications`** The ActiveRecord array of notifications including the currently rendered notification.

You may check whether a template is being used for grouping by using the `notification_grouped?` helper method.

#### Grouping by notification types

It is common, if rendering multiple notification types at once, to group the notifications by their type:

```erb
<%= render_notifications_grouped Notification.all, ['object.article'], group_by_type: true %>
```

This is identical to the following:

```erb
<%= render_notifications_grouped Notification.all, [:type, 'object.article'] %>
```

#### Grouping by notification dates

It is also often required to group notifications by their date of creation:

```erb
<%= render_notifications_grouped Notification.all, ['object.article'], group_by_date: :month %>
```

This is identical to the following:

```erb
<%= render_notifications_grouped Notification.all, ['created_at.beginning_of_month', 'object.article'] %>
```

Accepted values are:

* `:minute`
* `:hour`
* `:day`
* `:week`
* `:month`
* `:year`

**Note:** If used together with `group_by_type`, notifications will be grouped first by creation date and then by `:type`.

## Configuration

You can configure notification-renderer by passing a block to `configure`. This can be done in `config/initializers/notification-renderer.rb`:

```ruby
NotificationRenderer.configure do |config|
  config.default_type = 'notification'
end
```

**`default_type`** Choose your default notification type. Takes a string. Defaults to `'notification'`.

**`default_renderer`** Choose your default renderer. Takes a string. Defaults to `'index'`.

**`auto_read`** Automatically mark rendered notifications as read. Takes a boolean. Defaults to `true`.

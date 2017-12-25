# NotificationRenderer

[![Gem Version](https://badge.fury.io/rb/notification-renderer.svg)](https://badge.fury.io/rb/notification-renderer) <img src="https://travis-ci.org/jonhue/notifications-rails.svg?branch=master" />

Render your notifications on multiple platforms by specifying notification types.

---

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
    * [Types](#types)
        * [Generating a new type](#generating-a-new-type)
        * [Using a type](#using-a-type)
    * [Renderers](#renderers)
    * [View helpers](#view-helpers)
        * [`render_notification`](#render_notification)
        * [`render_notifications`](#render_notifications)
    * [Grouping](#grouping)
* [Configuration](#configuration)
* [To Do](#to-do)
* [Contributing](#contributing)
    * [Contributors](#contributors)
    * [Semantic versioning](#semantic-versioning)
* [License](#license)

---

## Installation

NotificationRenderer works with Rails 5 onwards. You can add it to your `Gemfile` with:

```ruby
gem 'notification-renderer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install notification-renderer

If you always want to be up to date fetch the latest from GitHub in your `Gemfile`:

```ruby
gem 'notification-renderer', github: 'jonhue/notifications-rails/tree/master/notification-renderer'
```

Now run the generator:

    $ rails g notification_renderer:install

To wrap things up, migrate the changes to your database:

    $ rails db:migrate

---

## Usage

### Types

NotificationRenderer uses templates to render your notifications.

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
notification = Notification.create target: User.first, object: Recipe.first, type: 'notification'
```

**Note:** The `type` attribute of any new `Notification` record will default to the [`default_type` configuration](#configuration).

### Renderers

In your renderers you can access the `Notification` record through the `notification` variable. This is how a renderer could look like:

```erb
<%= notification.target.name %> commented on <%= notification.object.article.title %>.
```

### View helpers

NotificationRenderer introduces some view helpers to assist you in embedding notifications.

#### `render_notification`

`render_notification` renders a single `Notification` record:

```erb
<%= render_notification Notification.first %>
```

Rendering a notification will set its `read` attribute to `true`.

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
Notification.grouping('object.article')
Notification.grouping('metadata[:title]')
```

When rendering notifications you often want to group them by the object they belong to. This is how to group notifications by the associated object:

```erb
<%= render_notifications_grouped Notification.all, 'object', 'feed' %>
```

You can also group notifications by nested attributes:

```erb
<%= render_notifications_grouped Notification.all, 'object.article' %>
<%= render_notifications_grouped Notification.all, 'metadata[:title]' %>
```

It is also possible to group notifications for just one object:

```erb
<%= render_notifications_grouped Notification.where(object_id: 1, object_type: 'Comment'), 'object' %>
```

This will render the last notification for every group and pass the attributes value grouped by to your renderer:

```erb
<!-- View -->

<%= render_notifications_grouped Notification.all, 'object.article' %>


<!-- Renderer -->

<% if notification_grouped? %>
    <%= notification.target.name %> and <%= (notification_count - 1).to_s %> others commented on <%= attribute.title %>.
<% else %>
    <%= notification.target.name %> commented on <%= notification.object.article.title %>.
<% end %>
```

Grouping makes the following two methods available in your renderer:

**`attribute`** The value of the attribute used for grouping.

**`notification_count`** The notification count for the group of the current notification.

You may check whether a template is being used for grouping by using the `notification_grouped?` helper method.

---

## Configuration

You can configure NotificationRenderer by passing a block to `configure`. This can be done in `config/initializers/notification-renderer.rb`:

```ruby
NotificationRenderer.configure do |config|
    config.default_type = 'notification'
end
```

**`default_type`** Choose your default notification type. Takes a string. Defaults to `'notification'`.

**`default_renderer`** Choose your default renderer. Takes a string. Defaults to `'index'`.

---

## To Do

[Here](https://github.com/jonhue/notifications-rails/projects/7) is the full list of current projects.

To propose your ideas, initiate the discussion by adding a [new issue](https://github.com/jonhue/notifications-rails/issues/new).

---

## Contributing

We hope that you will consider contributing to NotificationRenderer. Please read this short overview for some information about how to get started:

[Learn more about contributing to this repository](https://github.com/jonhue/notifications-rails/blob/master/CONTRIBUTING.md), [Code of Conduct](https://github.com/jonhue/notifications-rails/blob/master/CODE_OF_CONDUCT.md)

### Contributors

Give the people some :heart: who are working on this project. See them all at:

https://github.com/jonhue/notifications-rails/graphs/contributors

### Semantic Versioning

NotificationRenderer follows Semantic Versioning 2.0 as defined at http://semver.org.

## License

MIT License

Copyright (c) 2017 Jonas Hübotter

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

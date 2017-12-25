# NotificationsRails

[![Gem Version](https://badge.fury.io/rb/notifications-rails.svg)](https://badge.fury.io/rb/notifications-rails) <img src="https://travis-ci.org/jonhue/notifications-rails.svg?branch=master" />

The most powerful notification solution for Rails. NotificationsRails simplifies the handling, rendering, user-integration and cross-platform pushing of notifications through its simple API.

---

## Table of Contents

* [Philosophy](#philosophy)
* [Installation](#installation)
* [To Do](#to-do)
* [Contributing](#contributing)
    * [Contributors](#contributors)
    * [Semantic versioning](#semantic-versioning)
* [License](#license)

---

## Philosophy

NotificationsRails has been built with modularity in mind. It currently consists of four components each of which bringing one essential functionality to the notification-integration in your Rails app.

**[NotificationHandler](notification-handler):** Create and modify your notifications through a simple API.

**[NotificationRenderer](notification-renderer):** Render your notifications on multiple platforms by specifying notification types.

**[NotificationPusher](notification-pusher):** Push your notifications to various services. Including [Email](notification-pusher-actionmailer), [ActionCable](notification-pusher-actioncable), [OneSignal (cross-platform notifications)](notification-pusher-onesignal).

**[NotificationSettings](notification-settings):** Integrates with your authentication solution to craft a personalized user notification platform.

You may just add the components you actually need, or instead use this gem to bundle everything for a complete notification solution.

---

## Installation

NotificationsRails works with Rails 5 onwards. You can add it to your `Gemfile` with:

```ruby
gem 'notifications-rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install notifications-rails

If you always want to be up to date fetch the latest from GitHub in your `Gemfile`:

```ruby
gem 'notifications-rails', github: 'jonhue/notifications-rails'
```

---

## To Do

[Here](https://github.com/jonhue/notifications-rails/projects) is the full list of current projects.

To propose your ideas, initiate the discussion by adding a [new issue](https://github.com/jonhue/notifications-rails/issues/new).

---

## Contributing

We hope that you will consider contributing to NotificationsRails. Please read this short overview for some information about how to get started:

[Learn more about contributing to this repository](CONTRIBUTING.md), [Code of Conduct](CODE_OF_CONDUCT.md)

### Contributors

Give the people some :heart: who are working on this project. See them all at:

https://github.com/jonhue/notifications-rails/graphs/contributors

### Semantic Versioning

NotificationsRails follows Semantic Versioning 2.0 as defined at http://semver.org.

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

# Notifications Rails

[![Gem Version](https://badge.fury.io/rb/notifications-rails.svg)](https://badge.fury.io/rb/notifications-rails) ![Travis](https://travis-ci.com/jonhue/notifications-rails.svg?branch=master)

The most powerful notification solution for Rails. Notifications Rails simplifies the handling, rendering, user-integration and cross-platform pushing of notifications through its simple API.

---

## Table of Contents

* [Philosophy](#philosophy)
* [Installation](#installation)
* [Testing](#testing)
* [Release](#release)
* [To do](#to-do)
* [Contributing](#contributing)
  * [Semantic versioning](#semantic-versioning)

---

## Philosophy

Notifications Rails has been built with modularity in mind. It currently consists of four components each of which bringing one essential functionality to the notification-integration in your Rails app.

**[NotificationHandler](notification-handler):** Create and modify your notifications through a simple API.

**[NotificationRenderer](notification-renderer):** Render your notifications on multiple platforms by specifying notification types.

**[NotificationPusher](notification-pusher):** Push your notifications to various services. Including [Email](notification-pusher/notification-pusher-actionmailer) & [OneSignal](notification-pusher/notification-pusher-onesignal).

**[NotificationSettings](notification-settings):** Integrates with your authentication solution to craft a personalized user notification platform.

You may just add the components you actually need, or instead use this gem to bundle everything for a complete notification solution.

---

## Installation

Notifications Rails works with Rails 5 onwards. You can add it to your `Gemfile` with:

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

## Testing

Tests are written with RSpec. Integration tests are located in `/spec`, unit tests can be found in `<module>/spec`.

1. Fork this repository
2. Clone your forked git locally
3. Install dependencies

    `$ bundle install`

4. Run tests

    `$ ./rspec`

5. Run RuboCop

    `$ bundle exec rubocop`

---

## Release

1. Review breaking changes and deprecations in CHANGELOG.md
2. Change the gem version [here](VERSION)
3. Reset CHANGELOG.md
4. Create a pull request to merge the changes into `master`
5. After the pull request was merged, create a new release listing the breaking changes and commits on `master` since the last release.
6. The release workflow will publish the gems to RubyGems and the GitHub Package Registry

---

## To do

We use [GitHub projects](https://github.com/jonhue/notifications-rails/projects/9) to coordinate the work on this project.

To propose your ideas, initiate the discussion by adding a [new issue](https://github.com/jonhue/notifications-rails/issues/new).

---

## Contributing

We hope that you will consider contributing to Notifications Rails. Please read this short overview for some information about how to get started:

[Learn more about contributing to this repository](CONTRIBUTING.md), [Code of Conduct](CODE_OF_CONDUCT.md)

### Semantic Versioning

Notifications Rails follows Semantic Versioning 2.0 as defined at http://semver.org.

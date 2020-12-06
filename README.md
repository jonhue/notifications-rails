# notifications-rails

notifications-rails is the most powerful notification library for Rails. It offers not only simple APIs to create and render notifications but also supports user-integration and cross-platform delivery of notifications.

## Philosophy

notifications-rails has been built with modularity in mind. It currently consists of four components each of which bringing one essential functionality to the integration of notifications in your Rails app.

**[notification-handler](notification-handler):** Create and modify your notifications through a simple API.

**[notification-renderer](notification-renderer):** Render your notifications in various contexts.

**[notification-pusher](notification-pusher):** Deliver your notifications to various services, including [Email](notification-pusher/notification-pusher-actionmailer) and [OneSignal](notification-pusher/notification-pusher-onesignal).

**[notification-settings](notification-settings):** Integrates with your authentication solution to craft a personalized user notification platform.

You may just use the components you actually need, or instead use this gem to bundle everything for a complete notification solution.

## Installation

You can add notifications-rails to your `Gemfile` with:

```ruby
gem 'notifications-rails'
```

And then run:

    $ bundle install

Or install it yourself as:

    $ gem install notifications-rails

If you always want to be up to date fetch the latest from GitHub in your `Gemfile`:

```ruby
gem 'notifications-rails', github: 'jonhue/notifications-rails'
```

## Usage

Details on usage are provided in the [documentation](#philosophy) of the specific modules.

## Development

To start development you first have to fork this repository and locally clone your fork.

Install the projects dependencies by running:

    $ bundle install

### Testing

Tests are written with RSpec. Integration tests are located in `/spec`, unit tests can be found in `<module>/spec`.

To run all tests:

    $ ./rspec

To run RuboCop:

    $ bundle exec rubocop

You can find all commands run by the CI workflow in `.github/workflows/ci.yml`.

## Contributing

We warmly welcome everyone who is intersted in contributing. Please reference our [contributing guidelines](CONTRIBUTING.md) and our [Code of Conduct](CODE_OF_CONDUCT.md).

## Releases

[Here](https://github.com/jonhue/notifications-rails/releases) you can find details on all past releases. Unreleased breaking changes that are on the current master can be found [here](CHANGELOG.md).

notifications-rails follows Semantic Versioning 2.0 as defined at http://semver.org. Reference our [security policy](SECURITY.md).

### Publishing

1. Review breaking changes and deprecations in `CHANGELOG.md`.
1. Change the gem version in `VERSION`.
1. Reset `CHANGELOG.md`.
1. Create a pull request to merge the changes into `master`.
1. After the pull request was merged, create a new release listing the breaking changes and commits on `master` since the last release.
1. The release workflow will publish the gems to RubyGems.

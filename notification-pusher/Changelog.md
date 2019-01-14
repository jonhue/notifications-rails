# Changelog

This project follows [semver 2.0.0](http://semver.org/spec/v2.0.0.html) and the
recommendations of [keepachangelog.com](http://keepachangelog.com/).

## (Unreleased)

### Breaking Changes

- Change Pusher API to not push immediately when initialized. **Important**: If you have any custom
  pushers, you need to add a `call` method to it and *move* any code out of `initialize` (except
  code that is just doing initialization) and into the `call` method. [#49] (#55)

### Deprecated

- None

### Added

- None

### Fixed

- ...

## 1.2.6 (2018-12-22)

## 1.2.5 (2018-04-25)

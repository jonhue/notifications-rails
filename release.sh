cd notification-handler
gem build notification-handler.gemspec
gem push notification-handler-$1.gem

cd ../notification-pusher
gem build notification-pusher.gemspec
gem push notification-pusher-$1.gem

cd notification-pusher-actioncable
gem build notification-pusher-actioncable.gemspec
gem push notification-pusher-actioncable-$1.gem

cd ../notification-pusher-actionmailer
gem build notification-pusher-actionmailer.gemspec
gem push notification-pusher-actionmailer-$1.gem

cd ../notification-pusher-onesignal
gem build notification-pusher-onesignal.gemspec
gem push notification-pusher-onesignal-$1.gem

cd ../../notification-renderer
gem build notification-renderer.gemspec
gem push notification-renderer-$1.gem

cd ../notification-settings
gem build notification-settings.gemspec
gem push notification-settings-$1.gem

cd ..
gem build notifications-rails.gemspec
gem push notifications-rails-$1.gem

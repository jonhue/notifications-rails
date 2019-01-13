# rubocop:disable all
#
# Seems to be necessary to prevent:
#     NameError:
#       uninitialized constant User::Notification
#     # gems/activerecord-5.2.2/lib/active_record/inheritance.rb:196:in `compute_type'
#     # gems/activerecord-5.2.2/lib/active_record/reflection.rb:422:in `compute_class'
#     # gems/activerecord-5.2.2/lib/active_record/reflection.rb:379:in `klass'
#     # gems/activerecord-5.2.2/lib/active_record/associations/association.rb:129:in `klass'
#     # gems/activerecord-5.2.2/lib/active_record/associations/collection_association.rb:35:in `reader'
#     # gems/activerecord-5.2.2/lib/active_record/associations/builder/association.rb:108:in `notifications'
#     # ./notification-handler/lib/notification_handler/target.rb:22:in `notify'
# probably due to has_many :notifications not specifying a full class_name.
#
# rubocop:enable all
#
class Notification < NotificationHandler::Notification
end

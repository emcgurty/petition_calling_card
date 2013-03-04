class UsersObserver < ActiveRecord::Observer
  
  observe :users

  def before_create(users)
    users.user_id = UUIDTools::UUID.timestamp_create().to_s
  end

  def after_create(users)
    Notifier.deliver_signup_notification(users)
  end

  def after_save(users)

    Notifier.deliver_activation(users) if users.recently_activated?
    Notifier.deliver_reset_password_notification(users) if users.recently_reset? && users.recently_password_reset?
    Notifier.deliver_get_username_notification(users) if users.recently_reset? && users.recently_username_get?
  end
end

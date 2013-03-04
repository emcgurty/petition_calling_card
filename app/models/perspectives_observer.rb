class PerspectivesObserver < ActiveRecord::Observer

  observe :perspectives

  def before_create(perspectives)
    perspectives.p_uuid = UUIDTools::UUID.timestamp_create().to_s
  end

  def after_create(perspectives)
    recipient = perspectives.email
    subject = "Thanks for offering your perspective comments"
    message = ""
    body = {:alias => perspectives.alias,
      :record_text => perspectives.record_text,
      :created_at => perspectives.created_at}
    return (Notifier.deliver_comments_received(recipient, subject, message, body))
  end
end


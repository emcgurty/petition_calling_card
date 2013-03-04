class LinkrequestObserver < ActiveRecord::Observer

  observe :linkrequest

#    def before_save(linkrequest)
#      linkrequest.id = UUIDTools::UUID.timestamp_create().to_s
#    end

  def before_create(linkrequest)
#    self.validate
#    linkrequest.id = UUIDTools::UUID.timestamp_create().to_s
  end

  def after_create(linkrequest)

    unless linkrequest.user_id.blank?
      recipient = linkrequest.email
      subject = 'Thanks for offering your link'
      message = ''
      body = {:first_name => linkrequest.first_name,
        :last_name => linkrequest.last_name,
        :mi => linkrequest.mi,
        :record_text => linkrequest.record_text,
        :url => linkrequest.organization_url,
        :orgainzation_name => linkrequest.organization_name}
      return (Notifier.deliver_contact(recipient, subject, message, body))
    end
  end

end

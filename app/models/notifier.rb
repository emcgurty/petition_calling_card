class Notifier < ActionMailer::Base

  #  default :charset => "utf-8"
  #  default :content_type => "text/html"
  
  def testmail(recipient, subject, message, body, sent_at = Time.now)
    do_contact(recipient, subject, message, body, sent_at = Time.now)

  end

  def contact(recipient, subject, message, body, sent_at = Time.now)
    do_contact(recipient, subject, message, body, sent_at = Time.now)

  end

  def signature_comments(recipient, subject, message, body, sent_at = Time.now)
    do_contact(recipient, subject, message, body, sent_at = Time.now)

  end


  def comments_received(recipient, subject, message, body, sent_at = Time.now)
    do_contact(recipient, subject, message, body, sent_at = Time.now)

  end


  def signup_notification(users)
    setup_email(users)
    @subject    += ' Please activate your new account'
    @body[:url]  = "http://#{CollaboratorMethods.collaborator_value[:collaborator][:url]}/users/activate/#{users.activation_code}"
  end

  def activation(users)
    setup_email(users)
    @subject    += ' Your account has been activated!'
    @body[:url]  = "http://#{CollaboratorMethods.collaborator_value[:collaborator][:url]}/"
  end

  def reset_password_notification(users)
    setup_email(users)
    @subject    += ' Follow this link to reset your password'
    @body[:url]  = "http://#{CollaboratorMethods.collaborator_value[:collaborator][:url]}/users/reset_password/#{users.reset_code}"
  end

  def get_username_notification(users)
    setup_email(users)
    @subject    += ' Follow this link to learn your username'
    @body[:url]  = "http://#{CollaboratorMethods.collaborator_value[:collaborator][:url]}/users/get_username/#{users.reset_code}"
  end

  protected
  def setup_email(users)
    @recipients  = "#{users.email}"
    @from        = CollaboratorMethods.collaborator_value[:collaborator][:email]
    @subject     = CollaboratorMethods.collaborator_value[:collaborator][:url]
    @sent_on     = Time.now
    @body[:users] = users

  end

  private

  def do_contact(recipient, subject, message, body, sent_at = Time.now)

    @subject = subject
    @recipients = recipient
    @from = CollaboratorMethods.collaborator_value[:collaborator][:email]
    @message = message
    @sent_on = sent_at
    @body = body
    #@headers = {}

  end

end

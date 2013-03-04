# To change this template, choose Tools | Templates
# and open the template in the editor.

class SignaturesObserver < ActiveRecord::Observer

  observe :signatures

  def before_create(signatures)
    signatures.uuid = UUIDTools::UUID.timestamp_create().to_s
  end

  def after_create(signatures)
    unless signatures.comments.blank?
      @perspective = Perspectives.new('record_text' => signatures.comments, 'alias' => signatures.alias, 'email' => signatures.email, 'remote_ip' => signatures.remote_ip)
      @perspective.save(:validate => false)
      
    end
 
  end
end

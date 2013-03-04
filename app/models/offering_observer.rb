class OfferingObserver < ActiveRecord::Observer
  
  observe :offering

#  def before_create(offering)
#    offering.id = UUIDTools::UUID.timestamp_create().to_s
#  end
  
end

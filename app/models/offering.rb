class Offering < ActiveRecord::Base
  belongs_to :linkrequest
  attr_accessor :destroy_offering

  validates_presence_of :resource_url,:resource_description, :message => 'is a required field.'

  def validate
    unless url_valid?(resource_url)
      errors.add(resource_url, "... url not in standard format")
    end
  end

  def url_valid?(url)
    url = URI.parse(url) rescue false
    # TODO Modify textbox to prefix with https:// or http://
    #  url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
  end
end

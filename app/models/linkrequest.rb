class Linkrequest < ActiveRecord::Base
  
  attr_accessor :uploaded_picture
  has_many :offerings, :dependent => :destroy


  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  name_alpha_regex = /\A[ a-zA-Z'-]+\z/
  mi_alpha_regex = /\A[a-zA-Z]+\z/
  alpha_numeric_regex = /\A[0-9 a-zA-Z:;.,!?'-]+\z/
  alpha_numeric_regex_msg = "must be alphanumeric characters with typical writing punctuation."


  validates_presence_of :organization_url,:email,:record_text,:organization_name,:first_name,:last_name,:city,:country_id,:state_id,:zip_code, :message => 'is a required field.'
  #
  def validate
    unless url_valid?(organization_url)
      errors.add(:organization_url, "... url not in standard format")
    end
    

#    unless Linkrequest.find(:all, :conditions => ['organization_name = ?', self.organization_name]).blank?
#      errors.add(:organization_name, "... organization name already exists on this database")
#    end
  end

  #  validates_format_of :organization_name,   :on => 'create', :with => alpha_numeric_regex, :message => alpha_numeric_regex_msg

  #  validates_length_of :record_text, :maximum => 100, :on => 'create',  :too_long => "%{count} characters is the maximum allowed for the Organization name."
  #  validates_length_of :organization_url,   :maximum => 100, :on => 'create', :too_long => "%{count} characters is the maximum allowed for the Organization url."
  #  validates_format_of :organization_url, :with =>
  #
  #  validates_format_of :record_text,   :on => 'create', :with => alpha_numeric_regex, :message => alpha_numeric_regex_msg
  #  validates_length_of :record_text, :maximum => 255, :on => 'create',  :too_long => "%{count} characters is the maximum allowed for the Organization Mission."
  #

  #  validates_format_of :last_name,    :on => 'create', :with => name_alpha_regex, :message => "must be a alpha-character, no numbers"
  #  validates_length_of :mi, :is => 1, :on => 'create', :allow_blank => true,        :message => "is not a valid size."
  #  validates_format_of :mi,           :on => 'create', :allow_blank => true,        :with => mi_alpha_regex, :message => "must be a alpha-character, no numbers"
  #  validates_length_of :first_name, :maximum => 15, :on => 'create', :message => "is too many characters."
  #  validates_length_of :last_name, :maximum => 15, :on => 'create', :message => "is too many characters."
  #
  #  validates_length_of :city, :maximum => 15, :on => 'create', :message => "is too many characters."
  #
  #  validates_length_of :zip_code, :maximum => 12, :on => 'create', :message => "is too many characters."
  #
  #  validates_length_of :email,   :maximum => 50, :on => 'create', :message => "is too many characters."
  #  validates_format_of  :email,       :on => 'create', :with => email_regex, :message => "improperly formatted"
  #  validates_format_of :email, :without => /NOSPAM/, :message=> "can't include SPAM links."
  #

  #  validates_format_of :last_name,    :on => 'create', :with => name_alpha_regex, :message => "must be a alpha-character, no numbers"

  #  validates_format_of :city,         :on => 'create', :with =>  alpha_numeric_regex , :message => "must be alphanumeric characters"
  #
  #  validates_format_of :image_content_type, :allow_blank => true,
  #    :with => /^image/,
  #    :message => "--- you can only upload pictures"
  #  #
  #  #


  def url_valid?(url)
    url = URI.parse(url) rescue false
#    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
  end

  def destroy_offering
    # TODO something later
  end

  def uploaded_picture=(picture_field)
    unless (picture_field.blank?)
      name = base_part_of(picture_field.original_filename)
      directory = "public/images/collaborator/linkrequest_images"
      # create the file path
      path = File.join(directory, name)
      # write the file -- b is for binary
      File.open(path, "wb") { |f| f.write(picture_field.read) }
      self.image_file_name = name
      self.image_content_type = picture_field.content_type.chomp
    end
  end

  def base_part_of(file_name)
    File.basename(file_name).gsub(/[^\w._-]/, '')
  end
  #
end

class Signatures < ActiveRecord::Base

  set_primary_key :uuid
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  alpha_regex = /\A[ a-zA-Z'-]+\z/
  alpha_numeric_regex = /\A[ a-zA-Z0-9!?.:;'-]+\z/
  

  ##  validates :first_name, :presence => true,   :on => 'create', :message => "is a required field."
  #  validates_format_of :first_name,   :on => 'create', :with => alpha_regex, :message => "must contain only alpha-characters, no numbers"
  #  # validates_exclusion_of :first_name.to_s.downcase, :in => ObsceneWords, :message => ":no obscenity."
  #  validates_length_of :first_name, :maximum => 15, :on => 'create', :message => "is too many characters."
  #
  #  validates_length_of :mi, :is => 1, :allow_blank => true, :on => 'create', :message => "is not a valid size."
  #  validates_format_of :mi,          :allow_blank => true, :on => 'create', :with => alpha_regex, :message => "must contain only alpha-characters, no numbers"
  #
  #  validates_length_of :last_name, :maximum => 15, :on => 'create', :message => "is too many characters."
  #  # validates_exclusion_of :last_name.downcase, :in => ObsceneWords, :message => ":no obscenity."
  ##  validates :last_name, :presence => true, :on => 'create', :message => "is a required field."
  #  validates_format_of :last_name,    :on => 'create', :with => alpha_regex, :message => "must contain only alpha-characters, no numbers"
  #
  #  # validates_exclusion_of :alias.downcase, :in => ObsceneWords, :on => 'create', :message => "No obscenity."
  #  validates_length_of :alias, :on => 'create', :in => 6..16, :message => "must be between 6 and 16 characters"
  #  validates_uniqueness_of :alias, :on => 'create', :message => "is already being used."
  #  validates_uniqueness_of :alias, :scope=> [:first_name, :mi, :last_name] ,   :on => 'create', :message => "for the given name, the provided alias is already taken."
  #
  ##  validates  :YOB, :presence => true,  :on => 'create', :message => ", as presented here as 'Year of Birth' is a required field."
  #
  #
  #  validates_length_of :city, :maximum => 15, :on => 'create', :message => "is too many characters."
  #  validates_length_of :postal_code, :maximum => 12, :on => 'create', :message => "has a character limited of 12."
  #
  #
  #
  #  validates_format_of  :email, :allow_blank => true,       :on => 'create', :with => email_regex, :message => "improperly formatted"
  ##  validates :email,  :presence => true, :if => Proc.new { |a| not a.comments.blank? },  :on => 'create', :message => "is required in offering comments."
  #
  #
  #  validates_length_of :comments, :maximum => 255, :allow_blank => true, :on => 'create', :message => "permits 255 character, spaces are included in the count."
  #  validates_format_of :comments,    :on => 'create', :allow_blank => true, :with => alpha_numeric_regex, :message => "must contain only alphanumeric characters with typical punctuation"


  #  validates :signature_agreement, :presence => true, :is => 1,:on => 'create',     :message => ": you are required to attest that you are a responsible and earnest person."



  #  validates :address1,  :presence => true,  :on => 'create', :message => "is a required field."

  # validates_exclusion_of :address1.downcase, :in => ObsceneWords, :message => ":no obscenity."
  # validates_exclusion_of :address2.downcase, :in => ObsceneWords, :message => ":no obscenity."

  #  validates :city,  :presence => true,      :on => 'create', :message => "is a required field."
  # validates_exclusion_of :city.downcase,     :in => ObsceneWords, :message => ":no obscenity."
  #  validates_format_of :city,         :on => 'create', :with => alpha_regex , :message => "must be an alpha-character, no numbers"


end


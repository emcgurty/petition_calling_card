require 'active_support'    # for symbolize_keys
require 'yaml'

module CollaboratorValues
  #CollaboratorValues::CollaboratorMethods.collaborator_value
  class CollaboratorMethods 
    class << self
      attr_accessor :collaborator_value, :us_states, :collaborator, :countries, :display_rows
    

      def load_values
        @collaborator = Hash.new
        file = File.open("#{RAILS_ROOT}/collaborator/collaborator_values.yml")
        @collaborator_value = YAML::load(file)
      end

      #      def load_emails
      #        file = File.open("#{RAILS_ROOT}/collaborator/emails.yml")
      #        @collaborator_emails = YAML::load(file)[RAILS_ENV]
      #      end
      #
      #
      #      def load_active_tests(file_name)
      #        file = File.open("#{RAILS_ROOT}/collaborator/test/#{file_name}.yml")
      #        @collaborator_values_tests = YAML::load(file)
    end
  end
end


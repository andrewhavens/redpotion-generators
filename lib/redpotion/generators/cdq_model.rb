require "thor"
require_relative "./shared/model_generator_methods"

module RedPotion
  module Generators
    class CDQModel < Thor::Group
      include Thor::Actions

      argument :model_name
      argument :model_attributes, optional: true, type: :hash

      def self.source_root
        File.dirname(__FILE__)
      end

      def generate
        template "templates/cdq_model.tt", "app/models/#{model_name}.rb"
        check_for_previous_schema!
        template "templates/cdq_migration.tt", "schemas/#{new_schema_number}_create_#{model_name.underscore}.rb"
      end

      private
      include ModelGeneratorMethods
    end
  end
end

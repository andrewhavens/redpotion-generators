require "thor"
require_relative "./shared/model_generator_methods"

module RedPotion
  module Generators
    class Scaffold < Thor::Group
      include Thor::Actions

      argument :model_name
      argument :model_attributes, optional: true, type: :hash

      def self.source_root
        File.dirname(__FILE__)
      end

      def generate_model
        template "templates/cdq_model.tt", "app/models/#{model_name}.rb"
        check_for_previous_schema!
        template "templates/cdq_migration.tt", "schemas/#{new_schema_number}_create_#{model_name}.rb"
      end

      def generate_screens
        template "templates/cdq_table_screen.tt", "app/screens/#{model_name.pluralize}_screen.rb"
        template "templates/new_cdq_model_form_screen.tt", "app/screens/new_#{model_name}_screen.rb"
        template "templates/cdq_model_detail_screen.tt", "app/screens/#{model_name}_detail_screen.rb"
        template "templates/edit_cdq_model_form_screen.tt", "app/screens/edit_#{model_name}_screen.rb"
      end

      def generate_stylesheets
        template "templates/table_screen_stylesheet.tt", "app/stylesheets/#{model_name.pluralize}_screen_stylesheet.rb"
        template "templates/form_screen_stylesheet.tt", "app/stylesheets/#{model_name}_form_screen_stylesheet.rb"
        template "templates/detail_screen_stylesheet.tt", "app/stylesheets/#{model_name}_detail_screen_stylesheet.rb"
      end

      def enable_xlform_gem
        # TODO
      end

      private
      include ModelGeneratorMethods
    end
  end
end

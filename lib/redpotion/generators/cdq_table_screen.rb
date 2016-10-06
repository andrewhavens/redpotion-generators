require "thor"

module RedPotion
  module Generators
    class CDQTableScreen < Thor::Group
      include Thor::Actions

      argument :model_name

      def self.source_root
        File.dirname(__FILE__)
      end

      def generate_stylesheet
        template "templates/table_screen_stylesheet.tt", "app/stylesheets/#{model_name.pluralize}_screen_stylesheet.rb"
      end

      def generate_screen
        template "templates/cdq_table_screen.tt", "app/screens/#{model_name.pluralize}_screen.rb"
      end
    end
  end
end

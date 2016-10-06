module RedPotion
  module Generators
    module ModelGeneratorMethods

      def check_for_previous_schema!
        Dir["schemas/*.rb"].each do |filename|
          @previous_schema_filename = File.basename(filename)
          @previous_schema_number = @previous_schema_filename.to_i # automatically trims off non-integer characters
        end
      end

      def previous_schema_filename
        @previous_schema_filename
      end

      def previous_schema_number
        @previous_schema_number
      end

      def new_schema_number
        number = previous_schema_number || 0
        number += 1
        sprintf("%04d", number)
      end

      def previous_schema_content
        if previous_schema_number
          previous_schema_content = ""
          File.open("schemas/#{previous_schema_filename}") do |file|
            file.each_line do |line|
              unless line =~ /schema/ or line =~ /^end$/
                previous_schema_content += line
              end
            end
          end
          previous_schema_content
        end
      end

    end
  end
end

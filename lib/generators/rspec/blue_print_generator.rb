require 'generators/blue_print/base'

module Rspec
  class BluePrintGenerator < ::BluePrint::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def create_context_spec_file
      template 'context_spec.rb', File.join(
        'spec/blue_prints', class_path, "#{singular_name}_context_spec.rb"
      )
    end

    def create_behavior_files
      each_with_role do |role|
        template 'role_spec.rb', File.join(
          'spec/blue_prints', class_path, "#{file_name}_context", "#{role.underscore}_spec.rb"
        )
      end
    end
  end
end

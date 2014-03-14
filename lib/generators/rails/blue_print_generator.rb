require 'generators/blue_print/base'

module Rails
  module Generators
    class BluePrintGenerator < ::BluePrint::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      check_class_collision suffix: 'Context'

      class_option :parent, type: :string, desc:
        'The parent class for the generated context'
      class_option :active_if, type: :array, default: [], desc:
        'The active_if names for the generated context'

      def create_context_file
        template 'context.rb', File.join(
          'app/blue_prints', class_path, "#{file_name}_context.rb"
        )
      end

      def create_behavior_files
        each_with_role do |role|
          template 'role.rb', File.join(
            'app/blue_prints', class_path, "#{file_name}_context", "#{role.downcase}.rb"
          )
        end
      end

      hook_for :test_framework

      private

      def active_ifs
        options.fetch('active_if').map do |active_if|
          ":#{active_if}"
        end
      end

      def parent_class_name
        options.fetch('parent') { 'BluePrint::Context' }
      end
    end
  end
end

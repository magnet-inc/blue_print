require 'rails/generators'
require 'blue_print'

module BluePrint::Generators
  class Base < ::Rails::Generators::NamedBase
    argument :models, type: :array, default: [], banner: 'model[:roles] model[:roles]'

    private

    def models_with_roles
      models = Hash.new { |h, k| h[k] = [] }

      models_without_roles.each do |model|
        model_name, *roles = *model.split(':')

        models[model_name.classify] |= roles.map(&:classify)
      end

      models
    end
    alias_method_chain :models, :roles

    def roles
      models_with_roles.map(&:last).flatten.uniq
    end

    def each_with_role(&block)
      roles.each do |role|
        @role = role
        yield role
      end
    end
  end
end

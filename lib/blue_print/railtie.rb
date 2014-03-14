require 'blue_print'

class BluePrint::Railtie < ::Rails::Railtie
  config.after_initialize do |app|
    app.config.paths.add 'app/blue_prints', eager_load: true
  end

  initializer 'blue_print' do |app|
  end

  initializer 'blue_print.acton_view' do
    ActiveSupport.on_load :action_view do
      require 'blue_print/railtie/action_view'
    end
  end

  initializer 'blue_print.action_controller' do
    ActiveSupport.on_load :action_controller do
      require 'blue_print/railtie/action_controller'
    end
  end

  initializer 'blue_print.active_record' do
    ActiveSupport.on_load :active_record do
      require 'blue_print/railtie/active_record'
    end
  end
end

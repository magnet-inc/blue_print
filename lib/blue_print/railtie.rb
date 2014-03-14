require 'blue_print'

class BluePrint::Railtie < ::Rails::Railtie
  initializer 'blue_print' do |app|
    ActiveSupport.on_load :action_view do
      ::ActionView::Base.send(:include, BluePrint::Helper)
    end

    ActiveSupport.on_load :action_controller do
      ::ActionController::Base.send(:include, BluePrint::Helper)
    end

    ActiveSupport.on_load :active_record do
      ::ActiveRecord::Base.send(:include, BluePrint::Helper)
      ::ActiveRecord::Relation.send(:include, BluePrint::Helper)
      ::ActiveRecord::Associations::CollectionAssociation\
        .send(:include, BluePrint::Helper)
    end
  end
end

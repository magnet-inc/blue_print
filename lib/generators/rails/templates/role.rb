<% module_namespacing do -%>
module <%= class_name %>Context::<%= @role %>
  extend BluePrint::Behavior

  module ClassMethods
  end
end
<% end -%>

<% module_namespacing do -%>
class <%= class_name %>Context < <%= parent_class_name.classify %>
  <%- if active_ifs.present? -%>
  active_if <%= active_ifs.join(', ') %>
  <%- else -%>
  active_if do |env|
    true
  end
  <%- end -%>

  <%- models.each_pair do |model, roles| -%>
  cast ::<%= model %>, as: [<%= roles.join(', ') %>]
  <%- end -%>
end
<% end -%>

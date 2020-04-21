#encoding: utf-8

# Add content in bottom of <table class="list custom_fields">
Deface::Override.new :virtual_path     => "custom_fields/_index",
                     :name             => "add_section_to_project_custom_fields_index",
                     :original         => "2511edf43662154e333c868c51fab914f5648315",
                     :replace_contents => "table.list.custom_fields>tbody",
                     :text             => <<-EOS
<% (@custom_fields_by_type[tab[:name]] || []).sort.each do |custom_field| -%>
  <% back_url = custom_fields_path(:tab => tab[:name]) %>
  <tr>
    <td class="name"><%= link_to custom_field.name, edit_custom_field_path(custom_field) %></td>
    <td><%= l(custom_field.format.label) %></td>
    <td><%= checked_image custom_field.is_required? %></td>
    <% if tab[:name] == 'IssueCustomField' %>
    <td><%= checked_image custom_field.is_for_all? %></td>
    <td><%= l(:label_x_projects, :count => @custom_fields_projects_count[custom_field.id] || 0) if custom_field.is_a? IssueCustomField and !custom_field.is_for_all? %></td>
    <% end %>
    <td class="buttons">
      <%= reorder_handle(custom_field, :url => custom_field_path(custom_field), :param => 'custom_field') %>
      <%= delete_link custom_field_path(custom_field) %>
    </td>
  </tr>
<% end %>
EOS

#encoding: utf-8

# Add content in bottom of <table class="list custom_fields">
Deface::Override.new :virtual_path     => "custom_fields/_index",
                     :name             => "add_section_to_project_custom_fields_index",
                     :original         => "2511edf43662154e333c868c51fab914f5648315",
                     :replace_contents => "table.list.custom_fields>tbody",
                     :text             => <<-EOS
<% custom_fields = (@custom_fields_by_type[tab[:name]] || []).sort
if tab[:name] == "ProjectCustomField"
  custom_fields = group_projects_custom_fields_by_section(custom_fields)
end %>

<% custom_fields.each do |entity|
  back_url = custom_fields_path(:tab => tab[:name]) %>

  <% if entity.is_a?(Hash) %>
    <tr class="section_custom_field">
      <td class="name">
        <%= link_to entity[:name], edit_custom_fields_section_path(entity[:id]) %>
        <% entity[:items].each do |item| %>
          <br />
          <span class="name">
            <%= link_to item.name, edit_custom_field_path(item) %>
          </span>
        <% end %>
      </td>
      <td>
        <% entity[:items].each do |item| %>
          <br />
          <span><%=  l(item.format.label) %></span>
        <% end %>
      </td>
      <td></td>
      <td class="buttons">
        <%= reorder_handle(entity, :url => custom_field_path(entity[:items].first), :param => 'custom_field') %>
        <%= delete_link custom_fields_section_path(entity[:id]) %>
      </td>
    </tr>
  <% else %>
    <tr>
      <td class="name"><%= link_to entity.name, edit_custom_field_path(entity) %></td>
      <td><%= l(entity.format.label) %></td>
      <td><%= checked_image entity.is_required? %></td>
      <% if tab[:name] == 'IssueCustomField' %>
      <td><%= checked_image entity.is_for_all? %></td>
      <td><%= l(:label_x_projects, :count => @custom_fields_projects_count[entity.id] || 0) if entity.is_a? IssueCustomField and !entity.is_for_all? %></td>
      <% end %>
      <td class="buttons">
        <%= reorder_handle(entity, :url => custom_field_path(entity), :param => 'custom_field') %>
        <%= delete_link custom_field_path(entity) %>
      </td>
    </tr>
  <% end %>
<% end %>
EOS

#encoding: utf-8

# Add content in bottom of <div class="splitcontentright">
Deface::Override.new virtual_path:   "custom_fields/_form",
                     original:       "f730bb275511ba2092ae2acfba22186918b93a51",
                     name:           "add_section_to_project_custom_fields",
                     insert_bottom:  "div.splitcontentright",
                     text:           <<-EOS
<% if %w(ProjectCustomField).include?(@custom_field.class.name) %>
  <fieldset class="box tabular">
    <p>
      <%= f.label :section_id %>
      <%= f.collection_select :section_id, CustomFieldsSection.all, :id, :name, include_blank: true %>
    </p>
  </fieldset>
<% end %>
EOS

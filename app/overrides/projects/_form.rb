#encoding: utf-8

# Remove existent custom_fields on projects/_form page
Deface::Override.new :virtual_path      => "projects/_form",
                     :original          => "785a6bfc5ed26ff7866c048622711da14149f8ae",
                     :name              => "remove_custom_fields_generation_in_projects_form",
                     :remove            => "erb[loud]:contains('custom_field_tag_with_label')"

Deface::Override.new :virtual_path      => "projects/_form",
                     :name              => "remove_empty_p_in_projects_form",
                     :original          => "515bd358bb7d990930f0e2b3de399db1787a2567",
                     :remove            => "p:empty"

# Add custom code to add Section to custom_fields
# Deface::Override.new :virtual_path      => "projects/_form",
#                      :name              => "add_custom_fields_with_section_in_projects_form",
#                      :insert_bottom     => "div#tab-content-info form div.tabular:first-child",
#                      :partial           => "projects/_section_custom_fields"

#encoding: utf-8

# Remove existent custom_fields on projects/_form page
Deface::Override.new virtual_path:       "projects/_form",
                     name:               "remove_custom_fields_generation_in_projects_form",
                     remove:             "erb[loud]:contains('custom_field_tag_with_label')"

Deface::Override.new virtual_path:       "projects/_form",
                     name:               "remove_empty_p_in_projects_form",
                     remove:             "p:empty"

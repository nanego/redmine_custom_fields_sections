#encoding: utf-8

# Remove existent custom_fields on projects/_form page
Deface::Override.new virtual_path:       "projects/_form",
                     original:           "785a6bfc5ed26ff7866c048622711da14149f8ae",
                     name:               "remove_custom_fields_generation_in_projects_form",
                     remove:             "erb[loud]:contains('custom_field_tag_with_label')"

Deface::Override.new virtual_path:       "projects/_form",
					 original:           "515bd358bb7d990930f0e2b3de399db1787a2567",
                     name:               "remove_empty_p_in_projects_form",
                     remove:             "p:empty"

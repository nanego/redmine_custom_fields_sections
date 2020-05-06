#encoding: utf-8

# Add content in bottom of <table class="list custom_fields">
Deface::Override.new :virtual_path     => "custom_fields/_index",
                     :name             => "add_section_to_project_custom_fields_index",
                     :original         => "2511edf43662154e333c868c51fab914f5648315",
                     :replace_contents => "table.list.custom_fields>tbody",
                     :partial          => "custom_fields/list_custom_fields_in_sections"

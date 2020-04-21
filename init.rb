Rails.application.config.to_prepare do
  require_dependency "redmine_custom_fields_sections/project_custom_field_patch"
end

Redmine::Plugin.register :redmine_custom_fields_sections do
  name "Redmine Custom Fields Sections plugin"
  author "Vincent Robert"
  description "This plugin gives possibility to group custom fields in sections."
  version "0.0.1"
  url "https://github.com/nanego/redmine_custom_fields_sections"
  author_url "https://github.com/nanego"

  menu :admin_menu, :custom_fields_section,
                    { :controller => "custom_fields_sections", :action => "index" },
                    :caption => :custom_fields_section_caption,
                    :after => :custom_fields,
                    :html => { :class => "icon icon-custom-fields custom-fields" }
end

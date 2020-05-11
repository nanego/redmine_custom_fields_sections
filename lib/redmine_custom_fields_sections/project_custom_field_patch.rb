require_dependency "project_custom_field"

class ProjectCustomField
  belongs_to :section, class_name: "CustomFieldsSection", optional: true

  safe_attributes("section_id")
end

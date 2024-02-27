require_dependency "project_custom_field"

module RedmineCustomFieldsSections
  module ProjectCustomFieldPatch
    def self.included(base)
      base.class_eval do
        belongs_to :section, class_name: "CustomFieldsSection", optional: true

        safe_attributes("section_id")
      end
    end
  end
end

ProjectCustomField.send(:include, RedmineCustomFieldsSections::ProjectCustomFieldPatch)

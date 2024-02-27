require_dependency "custom_fields_helper"

module RedmineCustomFieldsSections::CustomFieldsHelperPatch
  def group_projects_custom_fields_by_section(project_custom_fields)
    grouped = []

    project_custom_fields.each do |cf|
      if cf.section.present?
        if (section = grouped.find {|e| e[:name] == cf.section.name })
          position = grouped.index(section)
          grouped[position][:items] << cf
        else
          grouped << { id: cf.section.id, name: cf.section.name, items: [cf] }
        end
      else
        grouped << cf
      end
    end

    grouped
  end

  def group_projects_custom_fields_values_by_section(project_custom_fields_values)
    grouped = []

    project_custom_fields_values.each do |cfv|
      if cfv.custom_field.section.present?
        if (section = grouped.find {|e| e.is_a?(Hash) && e[:name] == cfv.custom_field.section.name })
          position = grouped.index(section)
          grouped[position][:items] << cfv
        else
          grouped << { id: cfv.custom_field.section.id, name: cfv.custom_field.section.name, items: [cfv] }
        end
      else
        grouped << cfv
      end
    end

    grouped
  end
end

CustomFieldsHelper.prepend RedmineCustomFieldsSections::CustomFieldsHelperPatch
ActionView::Base.send(:include, CustomFieldsHelper)

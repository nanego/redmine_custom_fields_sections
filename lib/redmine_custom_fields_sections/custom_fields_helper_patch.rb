require_dependency "custom_fields_helper"

module CustomFieldsHelper
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
end

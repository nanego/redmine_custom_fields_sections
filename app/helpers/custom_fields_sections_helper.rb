module CustomFieldsSectionsHelper
  def custom_fields_section_title(custom_fields_section)
    items = []
    items << [l(:custom_fields_section_caption), custom_fields_sections_path]
    items << (custom_fields_section.nil? || custom_fields_section.new_record? ? l(:label_custom_field_section_new) : custom_fields_section.name)

    title(*items)
  end
end

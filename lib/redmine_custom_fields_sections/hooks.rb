module RedmineCustomFieldsSections
  class Hooks < Redmine::Hook::ViewListener

    # Add our css/js on each page
    def view_layouts_base_html_head(context)
      stylesheet_link_tag("section_custom_fields", :plugin => "redmine_custom_fields_sections")
    end

    render_on :view_projects_form, :partial => "projects/section_custom_fields"
  end
end

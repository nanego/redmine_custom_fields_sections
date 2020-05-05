require "spec_helper"

describe CustomFieldsSectionsHelper, type: :helper do
  include ApplicationHelper

  it "should return title for new custom fields section" do
    section = CustomFieldsSection.new(name: "Test section")
    title = custom_fields_section_title(section)

    expect(title).to eq "<h2><a href=\"/custom_fields_sections\">Custom Fields sections</a> &#187; New custom fields section</h2>"
  end

  it "should return title for existing custom fields section" do
    section = CustomFieldsSection.create!(name: "Test section")
    title = custom_fields_section_title(section)

    expect(title).to eq "<h2><a href=\"/custom_fields_sections\">Custom Fields sections</a> &#187; Test section</h2>"
  end
end

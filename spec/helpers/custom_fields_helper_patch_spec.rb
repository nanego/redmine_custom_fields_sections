require "spec_helper"

describe "CustomFieldsHelperPatch", type: :helper do
  include CustomFieldsHelper

  fixtures :projects, :trackers, :issue_statuses, :issues,
           :enumerations, :users, :issue_categories,
           :projects_trackers,
           :roles,
           :member_roles,
           :members,
           :enabled_modules,
           :custom_fields,
           :attachments,
           :versions

  let(:section1) { CustomFieldsSection.new(name: "section1") }
  let(:section2) { CustomFieldsSection.new(name: "section2") }
  let(:custom_fields) do
    [
      ProjectCustomField.new(name: "field1", section: section1),
      ProjectCustomField.new(name: "field2", section: section1),
      ProjectCustomField.new(name: "field3"),
      ProjectCustomField.new(name: "field4", section: section2),
      ProjectCustomField.new(name: "field5"),
    ]
  end

  it "should return title for new custom fields section" do
    data = group_projects_custom_fields_by_section(custom_fields)

    expect(data.size).to eq(4)
    expect(data[0][:items].size).to eq(2)
    expect(data[1]).to be_a(ProjectCustomField)
    expect(data[2][:items].size).to eq(1)
    expect(data[3]).to be_a(ProjectCustomField)
  end

  it "should return title for existing custom fields section" do
    project = projects(:projects_001)
    custom_values = []

    custom_fields.each do |cf|
      custom_values << CustomFieldValue.new(custom_field: cf, customized: project)
    end

    data = group_projects_custom_fields_values_by_section(custom_values)

    expect(data.size).to eq(4)
    expect(data[0][:name]).to eq("section1")
    expect(data[0][:items].size).to eq(2)
    expect(data[1]).to be_a(CustomFieldValue)
    expect(data[2][:name]).to eq("section2")
    expect(data[2][:items].size).to eq(1)
    expect(data[3]).to be_a(CustomFieldValue)
  end
end

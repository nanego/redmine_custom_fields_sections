require "spec_helper"

describe CustomFieldsSection do

  fixtures :custom_fields

  describe "create and destroy" do
    it "creates a section with a name" do
      section = CustomFieldsSection.new(name: "Test section")
      expect(section.save).to eq true
    end

    it "doesen't create a section without a name" do
      section = CustomFieldsSection.new()
      expect(section.save).to eq false
    end

    it "destroys a record" do
      section = CustomFieldsSection.new(name: "Test section")
      expect(section.destroy).to eq section
    end
  end

  describe "add projects custom fields to section" do
    it "section to custom_fields" do
      section = CustomFieldsSection.new(name: "Test section")
      custom_fields(:custom_fields_003).update(section: section)

      expect(section.project_custom_fields.first.name).to eq "Development status"
    end
  end
end

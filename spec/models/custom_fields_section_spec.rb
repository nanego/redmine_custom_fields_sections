require "spec_helper"

describe CustomFieldsSection do

  fixtures :custom_fields

  describe "create and destroy" do
    it "creates a section with a name" do
      section = described_class.new(name: "Test section")
      expect(section.save).to eq true
    end

    it "doesn't create a section without a name" do
      section = described_class.new()
      expect(section.save).to eq false
    end

    it "doesn't create a section with a not unique name" do
      described_class.create(name: "Test section")

      section = described_class.new(name: "Test section")
      expect(section.save).to eq false
    end

    it "destroys a record" do
      section = described_class.new(name: "Test section")
      expect(section.destroy).to eq section
    end
  end

  describe "add projects custom fields to section" do
    it "section to custom_fields" do
      section = described_class.new(name: "Test section")
      custom_fields(:custom_fields_003).update(section: section)

      expect(section.project_custom_fields.first.name).to eq "Development status"
    end
  end
end

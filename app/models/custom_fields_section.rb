class CustomFieldsSection < ActiveRecord::Base
  has_many :project_custom_fields, foreign_key: "section_id", class_name: "CustomField", :dependent => :nullify

  validates :name, :presence => true
end

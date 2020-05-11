class MakeSectionNameUnique < ActiveRecord::Migration[5.2]
  def change
    add_index :custom_fields_sections, :name, unique: true
  end
end

class CreateCustomFieldsSections < ActiveRecord::Migration[5.2]
  def change
    create_table :custom_fields_sections do |t|
      t.string :name, :null => false
      t.datetime :created_on, :null => false
    end

    add_reference :custom_fields, :section, :index => true, :foreign_key => { to_table: :custom_fields_sections }
  end
end





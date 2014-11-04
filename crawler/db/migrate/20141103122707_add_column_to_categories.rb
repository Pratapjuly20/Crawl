class AddColumnToCategories < ActiveRecord::Migration
  def change
  	add_column :categories, :parent_id, :integer
  	add_column :categories, :subcategory_name, :string
  	add_column :categories, :subcategory_link_address, :text
  end
end
